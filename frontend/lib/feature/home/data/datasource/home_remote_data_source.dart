import 'package:cookify/feature/home/data/model/recipe_preview_dto.dart';
import 'package:dio/dio.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<RecipePreviewDto>> getRecipeList();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<RecipePreviewDto>> getRecipeList() async {
    final response = await _dio.get('http://localhost:5022/api/recipes');

    return (response.data as List)
        .map((json) => RecipePreviewDto.fromJson(json))
        .toList();
  }
}
