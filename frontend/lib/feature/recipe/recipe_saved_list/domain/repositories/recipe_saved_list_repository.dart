import 'package:cookify/feature/recipe/recipe_saved_list/domain/entities/saved_recipe_preview_entity.dart';

abstract interface class RecipeSavedListRepository {
  Future<List<SavedRecipePreviewEntity>> getSavedRecipes();
}
