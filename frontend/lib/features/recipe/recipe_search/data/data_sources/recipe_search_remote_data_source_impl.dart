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
      '/api/search/recipes${request.lastId != null ? 'lastId=${request.lastId}' : ''}',
    );

    return (response.data['items'] as List)
        .map((json) => RecipePreviewModel.fromJson(json))
        .toList();
  }
}
