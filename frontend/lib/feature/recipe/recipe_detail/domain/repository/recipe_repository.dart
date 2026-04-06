import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe.dart';
import 'package:dartz/dartz.dart';

abstract class RecipeRepository {
  Future<Either<Failure, Recipe>> getRecipe(String id);
}
