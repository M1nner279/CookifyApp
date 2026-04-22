import 'package:cookify/features/recipe/recipe_feed/data/data_sources/recipe_feed_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_feed/data/models/recipe_preview_model.dart';
import 'package:cookify/features/recipe/recipe_feed/data/requests/get_recipe_list_request.dart';
import 'package:dio/dio.dart';

class RecipeFeedRemoteDataSourceImpl implements RecipeFeedRemoteDataSource {
  RecipeFeedRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<RecipePreviewModel>> getRecipeList(
    GetRecipeListRequest request,
  ) async {
    final response = await _dio.get(
      '/api/recipes${request.lastId != null ? '?lastId=${request.lastId}' : ''}',
    );

    return (response.data['items'] as List)
        .map((json) => RecipePreviewModel.fromJson(json))
        .toList();
  }
}
