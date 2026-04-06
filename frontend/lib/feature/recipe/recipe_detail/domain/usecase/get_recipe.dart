import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe.dart';
import 'package:cookify/feature/recipe/recipe_detail/domain/repository/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecipe {
  GetRecipe({required RecipeRepository repository}) : _repository = repository;

  final RecipeRepository _repository;

  Future<Either<Failure, Recipe>> call(String id) {
    return _repository.getRecipe(id);
  }
}
