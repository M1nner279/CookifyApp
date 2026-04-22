import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/payloads/get_recipe_list_payload.dart';

abstract interface class RecipeFeedRepository {
  Future<List<RecipePreviewEntity>> getRecipeList(GetRecipeListPayload payload);
}
