import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:cookify/shared/domain/entity/recipe_ingredient.dart';
import 'package:cookify/shared/domain/entity/recipe_step.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';

@freezed
abstract class Recipe with _$Recipe {
  const factory Recipe({
    String? id,
    required dynamic creator,
    required List<String> photoUrls,
    required String name,
    required List<Category> categories,
    required int cookingTime,
    required RecipeDifficulty difficulty,
    required Cpfc cpfc,
    required String description,
    required double servingCount,
    required List<RecipeIngredient> ingredients,
    required List<RecipeStep> steps,
  }) = _Recipe;
}
