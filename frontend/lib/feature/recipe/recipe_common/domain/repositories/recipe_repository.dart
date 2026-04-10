import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe.dart';

abstract interface class RecipeRepository {
  Future<void> saveRecipe(Recipe recipe);
}