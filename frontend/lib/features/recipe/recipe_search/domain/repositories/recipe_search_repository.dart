import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';

abstract interface class RecipeSearchRepository {
  Future<List<RecipePreviewEntity>> searchRecipeList(
    SearchRecipeListPayload payload,
  );
}
