import 'package:cookify/features/recipe/recipe_detail/data/models/recipe_detail_model.dart';
import 'package:cookify/features/recipe/recipe_feed/data/models/recipe_preview_model.dart';
import 'package:cookify/features/recipe/recipe_search/data/data_sources/recipe_search_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_search/data/requests/search_recipe_list_request.dart';
import 'package:dio/dio.dart';

class RecipeSearchRemoteDataSourceImpl implements RecipeSearchRemoteDataSource {
  RecipeSearchRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<RecipePreviewModel>> searchRecipeList(
    SearchRecipeListRequest request,
  ) async {
    final response = await _dio.get(
      '/api/search/recipes?${request.lastId != null ? 'lastId=${request.lastId}' : ''}',
      queryParameters: {
        'title': request.name,
        'difficulty': request.difficulties,
        'maxCookingTime': request.maxCookingTime,
        'minCarb': request.minCarbohydrates,
        'maxCarb': request.maxCarbohydrates,
        'minProtein': request.minProteins,
        'maxProtein': request.maxProteins,
        'minFat': request.minFats,
        'maxFat': request.maxFats,
        'minCalories': request.minCalories,
        'maxCalories': request.maxCalories,
        'tagIds': request.categoryIds,
        'ingredientIds': request.ingredients
      }
    );

    return (response.data as List)
        .map((json) => RecipePreviewModel.fromJson(json))
        .toList();
  }
}
