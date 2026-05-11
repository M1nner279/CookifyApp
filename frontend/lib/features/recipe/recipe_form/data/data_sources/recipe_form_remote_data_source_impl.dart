import 'dart:convert';
import 'dart:io';

import 'package:cookify/features/recipe/recipe_form/data/data_sources/recipe_form_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

class RecipeFormRemoteDataSourceImpl implements RecipeFormRemoteDataSource {
  RecipeFormRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Future<String> _fileToBase64(File file) async {
    List<int> bytes = await file.readAsBytes();
    String base64String = base64Encode(bytes);
    String mimeType = _getMimeType(file.path);
    return 'data:$mimeType;base64,$base64String';
  }

  // Функция для определения MIME типа
  String _getMimeType(String filePath) {
    String extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }

  @override
  Future<void> publishRecipe(PublishRecipePayload payload) async {
    List<Map<String, dynamic>> imagesData = [];
    for (int i = 0; i < payload.photos.length; i++) {
      String base64Image = await _fileToBase64(File(payload.photos[i].path));
      imagesData.add({'url': base64Image, 'order': i});
    }

    // Конвертируем фото шагов в base64
    List<Map<String, dynamic>> stepsData = [];
    for (int i = 0; i < payload.steps.length; i++) {
      Map<String, dynamic> stepData = {
        'title': payload.steps[i].title,
        'description': payload.steps[i].description,
      };

      if (payload.steps[i].photoPath != null) {
        String base64Image = await _fileToBase64(
          File(payload.steps[i].photoPath!),
        );
        stepData['image_base64'] = base64Image;
      } else {
        stepData['image_base64'] = null;
      }

      stepsData.add(stepData);
    }

    await _dio.post(
      '/api/recipes',
      data: {
        "title": payload.name,
        "cooking_time_minutes": payload.cookingTimeMinutes,
        "servings": 1,
        "calories100g": payload.calories,
        "protein100g": payload.proteins,
        "fat100g": payload.fats,
        "carb100g": payload.carbohydrates,
        "description": payload.description,
        "difficulty": payload.difficulty.index,
        "main_image_base64": imagesData.first['url'],
        "steps": stepsData,
        "tags": payload.categories,
        "ingredients": payload.ingredients
            .map((i) => {'id': i.id, 'amount': i.amount, 'unit': i.unit})
            .toList(),
      },
    );
  }
}
