import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/repositories/recipe_repository.dart';

class SaveRecipe {
  final RecipeRepository repository;
  SaveRecipe(this.repository);

  Future<void> call(Recipe recipe) => repository.saveRecipe(recipe);
}