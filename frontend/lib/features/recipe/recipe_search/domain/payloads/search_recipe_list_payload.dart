import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_recipe_list_payload.freezed.dart';

@freezed
abstract class SearchRecipeListPayload with _$SearchRecipeListPayload {
  const factory SearchRecipeListPayload({
    List<RecipePreviewEntity>? recipes,
    required String name,
    required List<RecipeDifficulty> difficulties,
    required List<CategoryEntity> categories,
    int? maxCookingTime,
    int? minCarbohydrates,
    int? maxCarbohydrates,
    int? minProteins,
    int? maxProteins,
    int? minFats,
    int? maxFats,
    int? minCalories,
    int? maxCalories,
    required List<IngredientEntity> ingredients,
  }) = _SearchRecipeListPayload;
}
