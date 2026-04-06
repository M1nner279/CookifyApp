import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/repository/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecipeList {
  GetRecipeList({required HomeRepository repository})
    : _repository = repository;

  final HomeRepository _repository;

  Future<Either<Failure, List<RecipePreview>>> call() {
    return _repository.getRecipeList();
  }
}
