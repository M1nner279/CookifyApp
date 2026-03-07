import 'package:cookify/core/error/failure.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe.dart';
import 'package:cookify/feature/recipe/domain/repository/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecipe {
  GetRecipe({required this.repository});

  final RecipeRepository repository;

  Future<Either<Failure, Recipe>> call(int id) {
    return repository.getRecipe(id);
  }
}