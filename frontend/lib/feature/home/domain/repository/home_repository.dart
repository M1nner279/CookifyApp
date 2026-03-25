import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<RecipePreview>>> getRecipeList();
}
