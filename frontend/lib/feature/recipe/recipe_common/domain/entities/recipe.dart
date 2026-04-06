import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/cpfc.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe_ingredient.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe_step.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';

@freezed
abstract class Recipe with _$Recipe {
  const factory Recipe({
    String? id,
    required dynamic creator,
    required List<String> photoUrls,
    required String name,
    required RecipeDifficulty difficulty,
    required List<CategoryEntity> categories,
    required int cookingTime,
    required Cpfc cpfc,
    required String description,
    required double servingCount,
    required List<RecipeIngredient> ingredients,
    required List<RecipeStep> steps,
  }) = _Recipe;
}
