import 'package:cookify/feature/recipe/recipe_saved_list/data/models/saved_recipe_preview_dto.dart';

abstract interface class RecipeSavedListLocalDataSource {
  Future<List<SavedRecipePreviewDto>> getSavedRecipes();
}
