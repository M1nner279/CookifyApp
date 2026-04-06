import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_step_dto.freezed.dart';
part 'recipe_step_dto.g.dart';

@freezed
abstract class RecipeStepDto with _$RecipeStepDto {
  const factory RecipeStepDto({
    required int id,
    required String? title,
    required String description,
    @JsonKey(name: 'image_url') required String imageUrl,
  }) = _RecipeStepDto;

  factory RecipeStepDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepDtoFromJson(json);
}
