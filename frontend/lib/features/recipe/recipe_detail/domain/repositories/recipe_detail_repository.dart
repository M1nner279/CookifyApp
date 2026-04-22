import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/payloads/get_recipe_detail_payload.dart';

abstract interface class RecipeDetailRepository {
  Future<RecipeDetailEntity> getRecipeDetail(GetRecipeDetailPayload payload);
}
