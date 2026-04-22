import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_preview_entity.freezed.dart';

@freezed
abstract class RecipePreviewEntity with _$RecipePreviewEntity {
  const factory RecipePreviewEntity({
    required String id,
    required String photoUrl,
    required String name,
    required int cookingTime,
    required int servingCount,
    required RecipeDifficulty difficulty,
    required List<String> categories,
  }) = _RecipePreviewEntity;
}
