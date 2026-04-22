import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_step_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_entity.freezed.dart';

@freezed
abstract class RecipeDetailEntity with _$RecipeDetailEntity {
  const factory RecipeDetailEntity({
    required String id,
    required dynamic creator,
    required List<String> photoUrls,
    required String name,
    required RecipeDifficulty difficulty,
    required List<CategoryEntity> categories,
    required int cookingTime,
    required CpfcEntity cpfc,
    required String description,
    required double servingCount,
    required List<RecipeIngredientEntity> ingredients,
    required List<RecipeStepEntity> steps,
  }) = _RecipeDetailEntity;
}
