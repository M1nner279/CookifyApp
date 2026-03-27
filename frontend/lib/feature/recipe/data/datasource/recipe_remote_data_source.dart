import 'package:cookify/shared/data/model/recipe_dto.dart';
import 'package:dio/dio.dart';

abstract class RecipeRemoteDataSource {
  Future<RecipeDto> getRecipe(int id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  RecipeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<RecipeDto> getRecipe(int id) async {
    final response = await _dio.get('http://localhost:5022/api/recipes/$id');

    return RecipeDto.fromJson(response.data);
  }
}
