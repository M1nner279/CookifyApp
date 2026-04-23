import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';

abstract class RecipeFormRemoteDataSource {
  Future<void> publishRecipe(PublishRecipePayload payload);
}
