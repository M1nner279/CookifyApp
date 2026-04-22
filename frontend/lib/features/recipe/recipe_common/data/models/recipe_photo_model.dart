import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_photo_model.freezed.dart';
part 'recipe_photo_model.g.dart';

@freezed
abstract class RecipePhotoModel with _$RecipePhotoModel {
  const factory RecipePhotoModel({
    required int id,
    required String url,
    required int order,
  }) = _RecipePhotoModel;

  factory RecipePhotoModel.fromJson(Map<String, dynamic> json) =>
      _$RecipePhotoModelFromJson(json);
}
