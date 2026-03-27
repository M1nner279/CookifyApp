import 'package:cookify/config/error/failure.dart';
import 'package:cookify/config/util/safecall/safe_data_source_call.dart';
import 'package:cookify/feature/home/data/datasource/home_remote_data_source.dart';
import 'package:cookify/feature/home/data/mapper/recipe_preview_mapper.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/home/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this._remoteDataSource});

  final HomeRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<RecipePreview>>> getRecipeList() async {
    return safeRemoteDataSourceCall(() async {
      final recipeDtos = await _remoteDataSource.getRecipeList();

      final recipes = recipeDtos.map((dto) => RecipePreviewMapper.fromDto(dto)).toList();

      return recipes;
    });
  }
}
