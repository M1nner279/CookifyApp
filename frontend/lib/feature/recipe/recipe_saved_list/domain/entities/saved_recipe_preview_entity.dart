import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_recipe_preview_entity.freezed.dart';

@freezed
abstract class SavedRecipePreviewEntity with _$SavedRecipePreviewEntity {
  const factory SavedRecipePreviewEntity({
    required String id,
    required String? serverId,
    required bool? isPublished,
    required String photoUrl,
    required RecipeDifficulty difficulty,
    required String name,
    required int cookingTime,
    required List<CategoryEntity> categories,
  }) = _SavedRecipePreviewEntity;
}
