import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';

abstract interface class UserSavedRecipeDetailRepository {
  Future<void> init();

  RecipeDetailEntity? getById(String recipeId);

  Future<void> save(String recipeId, RecipeDetailEntity detail);

  Future<void> remove(String recipeId);
}
