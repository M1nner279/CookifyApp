import 'package:cookify/features/recipe/recipe_detail/data/data_sources/recipe_detail_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_detail/data/models/recipe_detail_model.dart';
import 'package:cookify/features/recipe/recipe_detail/data/requests/get_recipe_detail_request.dart';
import 'package:dio/dio.dart';

class RecipeDetailRemoteDataSourceImpl implements RecipeDetailRemoteDataSource {
  RecipeDetailRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<RecipeDetailModel> getRecipeDetail(
    GetRecipeDetailRequest request,
  ) async {
    final response = await _dio.get('/api/recipes/${request.id}');

    return RecipeDetailModel.fromJson(response.data);
  }
}
