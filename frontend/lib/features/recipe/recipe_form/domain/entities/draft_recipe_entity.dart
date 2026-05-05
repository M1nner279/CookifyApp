import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'draft_recipe_entity.freezed.dart';

@freezed
abstract class DraftRecipeEntity with _$DraftRecipeEntity {
  const factory DraftRecipeEntity({
    required String id,
    required DateTime updatedAt,
    required String name,
    required String description,
    required CpfcEntity cpfc,
    required RecipeDifficulty difficulty,
    required int cookingTimeMinutes,
    required List<CategoryEntity> categories,
    required List<DraftRecipeIngredientEntity> ingredients,
    required List<DraftRecipeStepEntity> steps,
    required List<String> photoPaths,
  }) = _DraftRecipeEntity;
}

@freezed
abstract class DraftRecipeIngredientEntity with _$DraftRecipeIngredientEntity {
  const factory DraftRecipeIngredientEntity({
    required IngredientEntity ingredient,
    required double amount,
    required String unit,
  }) = _DraftRecipeIngredientEntity;
}

@freezed
abstract class DraftRecipeStepEntity with _$DraftRecipeStepEntity {
  const factory DraftRecipeStepEntity({
    required String title,
    required String description,
    String? photoPath,
  }) = _DraftRecipeStepEntity;
}

