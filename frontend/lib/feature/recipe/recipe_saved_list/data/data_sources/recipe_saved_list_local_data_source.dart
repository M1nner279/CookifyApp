import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_dto.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/models/saved_recipe_preview_dto.dart';

abstract interface class RecipeSavedListLocalDataSource {
  Future<List<RecipeDto>> getSavedRecipes();
}
