import 'package:cookify/features/recipe/recipe_form/data/data_sources/recipe_form_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';
import 'package:dio/dio.dart';

class RecipeFormRemoteDataSourceImpl implements RecipeFormRemoteDataSource {
  RecipeFormRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> publishRecipe(PublishRecipePayload payload) async {
    await _dio.post(
      '/api/recipes',
      data: {
        'name': payload.name,
        'description': payload.description,
        'cpfc': {
          'calories': payload.calories,
          'proteins': payload.proteins,
          'fats': payload.fats,
          'carbohydrates': payload.carbohydrates,
        },
        'difficulty': payload.difficulty,
        'cookingTimeMinutes': payload.cookingTimeMinutes,
        'categories': payload.categories,
        'photos': payload.photos.map((file) => file.path).toList(),
        'ingredients': payload.ingredients
            .map(
              (item) => {
                'id': item.id,
                'amount': item.amount,
                'unit': item.unit,
              },
            )
            .toList(),
        'steps': payload.steps
            .map(
              (item) => {
                'title': item.title,
                'description': item.description,
                if (item.photoPath != null) 'photo': item.photoPath,
              },
            )
            .toList(),
      },
    );
  }
}
