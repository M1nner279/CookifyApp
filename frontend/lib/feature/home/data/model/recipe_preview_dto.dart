import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_preview_dto.freezed.dart';
part 'recipe_preview_dto.g.dart';

@freezed
abstract class RecipePreviewDto with _$RecipePreviewDto {
  const factory RecipePreviewDto({
    required int id,
    required String title,
    @JsonKey(name: 'preview_image_url') required String imageUrl,
    @JsonKey(name: 'cooking_time_min') required int cookingTime,
    required int servings,
    required List<String> tags,
    required int difficulty,
  }) = _RecipePreviewDto;

  factory RecipePreviewDto.fromJson(Map<String, dynamic> json) => _$RecipePreviewDtoFromJson(json);
}
