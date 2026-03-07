import 'package:cookify/core/error/failure.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe.dart';
import 'package:dartz/dartz.dart';

abstract class RecipeRepository {
  Future<Either<Failure, Recipe>> getRecipe(int id);
}
