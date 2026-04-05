import 'package:cookify/config/error/failure.dart';
import 'package:cookify/config/util/safecall/safe_data_source_call.dart';
import 'package:cookify/feature/recipe/data/datasource/recipe_remote_data_source.dart';
import 'package:cookify/shared/data/mapper/recipe_mapper.dart';
import 'package:cookify/shared/domain/entity/recipe.dart';
import 'package:cookify/feature/recipe/domain/repository/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl({required this.remoteDataSource});

  final RecipeRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, Recipe>> getRecipe(String id) async {
    return safeRemoteDataSourceCall(() async {
      final recipeDto = await remoteDataSource.getRecipe(int.parse(id));

      final recipe = RecipeMapper.fromDto(recipeDto);

      return recipe;
    });
  }
}
