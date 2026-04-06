import 'package:cookify/feature/recipe/recipe_common/data/models/category_dto.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_recipe_preview_dto.freezed.dart';
part 'saved_recipe_preview_dto.g.dart';

@freezed
abstract class SavedRecipePreviewDto with _$SavedRecipePreviewDto {
  factory SavedRecipePreviewDto({
    required String id,
    required String? serverId,
    required bool? isPublished,
    required String photoUrl,
    required RecipeDifficulty difficulty,
    required String name,
    required int cookingTime,
    required List<CategoryDto> categories,
  }) = _SavedRecipePreviewDto;

  factory SavedRecipePreviewDto.fromJson(Map<String, dynamic> json) =>
      _$SavedRecipePreviewDtoFromJson(json);
}
