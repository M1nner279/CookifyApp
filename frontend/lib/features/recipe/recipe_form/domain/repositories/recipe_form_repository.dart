import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';

abstract class RecipeFormRepository {
  Future<void> publishRecipe(PublishRecipePayload payload);
}
