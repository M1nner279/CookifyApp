import 'package:cookify/feature/recipe/recipe_common/data/data_sources/recipe_local_data_source.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/repositories/recipe_repository.dart';
import 'package:cookify/shared/data/mapper/recipe_mapper.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl({required RecipeLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  final RecipeLocalDataSource _localDataSource;

  @override
  Future<void> saveRecipe(Recipe recipe) {
    return _localDataSource.saveRecipe(RecipeMapper.toDto(recipe));
  }
}
