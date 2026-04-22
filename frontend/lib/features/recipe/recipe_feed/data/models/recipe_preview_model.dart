import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_preview_model.freezed.dart';
part 'recipe_preview_model.g.dart';

@freezed
abstract class RecipePreviewModel with _$RecipePreviewModel {
  const factory RecipePreviewModel({
    required int id,
    @JsonKey(name: 'preview_image_url') required String photoUrl,
    @JsonKey(name: 'title') required String name,
    @JsonKey(name: 'cooking_time_min') required int cookingTime,
    @JsonKey(name: 'servings') required int servingCount,
    required int difficulty,
    @JsonKey(name: 'tags') required List<String> categories,
  }) = _RecipePreviewModel;

  factory RecipePreviewModel.fromJson(Map<String, dynamic> json) =>
      _$RecipePreviewModelFromJson(json);
}
