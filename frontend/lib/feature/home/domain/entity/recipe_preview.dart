import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_preview.freezed.dart';

@freezed
abstract class RecipePreview with _$RecipePreview {
  const factory RecipePreview({
    required String id,
    required List<String> photoUrls,
    required String name,
    required int cookingTime,
    required int servingCount,
    required RecipeDifficulty difficulty,
    required List<Category> categories,
  }) = _RecipePreview;
}
