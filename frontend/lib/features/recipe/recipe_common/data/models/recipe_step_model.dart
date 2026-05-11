import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_step_model.freezed.dart';
part 'recipe_step_model.g.dart';

@freezed
abstract class RecipeStepModel with _$RecipeStepModel {
  const factory RecipeStepModel({
    required int id,
    @JsonKey(name: 'title') String? name,
    @JsonKey(name: 'image_url') String? photoUrl,
    required String description,
    @JsonKey(name: 'step_number') required int stepNumber,
  }) = _RecipeStepModel;

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepModelFromJson(json);
}
