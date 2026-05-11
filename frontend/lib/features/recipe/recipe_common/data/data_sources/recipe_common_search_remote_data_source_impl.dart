import 'package:cookify/features/recipe/recipe_common/data/data_sources/recipe_common_search_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_common/data/models/category_model.dart';
import 'package:cookify/features/recipe/recipe_common/data/models/ingredient_model.dart';
import 'package:cookify/features/recipe/recipe_common/data/requests/search_category_list_request.dart';
import 'package:cookify/features/recipe/recipe_common/data/requests/search_ingredient_list_request.dart';
import 'package:dio/dio.dart';

class RecipeCommonSearchRemoteDataSourceImpl
    implements RecipeCommonSearchRemoteDataSource {
  RecipeCommonSearchRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<CategoryModel>> searchCategoryList(
    SearchCategoryListRequest request,
  ) async {
    final response = await _dio.get(
      '/api/search/tags?name=${request.name}',
    );

    return (response.data as List)
        .map((json) => CategoryModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<IngredientModel>> searchIngredientList(
    SearchIngredientListRequest request,
  ) async {
    final response = await _dio.get(
      '/api/search/ingredients?name=${request.name}',
    );

    return (response.data as List)
        .map((json) => IngredientModel.fromJson(json))
        .toList();
  }
}
