import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:flutter/foundation.dart';

abstract interface class SavedRecipeRepository {
  ValueListenable<List<RecipePreviewEntity>> get savedRecipesListenable;

  List<RecipePreviewEntity> get savedRecipes;

  bool isSaved(String recipeId);

  Future<void> init();

  Future<void> saveRecipe(RecipePreviewEntity recipe);

  Future<void> removeRecipe(String recipeId);

  Future<void> toggleRecipe(RecipePreviewEntity recipe);
}
