import 'package:cookify/config/error/failure.dart';
import 'package:cookify/config/util/safecall/safe_data_source_call.dart';
import 'package:cookify/feature/recipe/recipe_feed/datasource/home_remote_data_source.dart';
import 'package:cookify/feature/home/data/mapper/recipe_preview_mapper.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this.remoteDataSource});

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<RecipePreview>>> getRecipeList() async {
    return safeRemoteDataSourceCall(() async {
      final recipeDtos = await remoteDataSource.getRecipeList();

      final recipes = recipeDtos.map((dto) => RecipePreviewMapper.fromDto(dto)).toList();

      return recipes;
    });
  }
}
