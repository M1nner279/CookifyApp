import 'package:cookify/features/recipe/recipe_common/data/models/recipe_photo_model.dart';
import 'package:cookify/features/recipe/recipe_common/data/models/recipe_ingredient_model.dart';
import 'package:cookify/features/recipe/recipe_common/data/models/recipe_step_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_model.freezed.dart';
part 'recipe_detail_model.g.dart';

@freezed
abstract class RecipeDetailModel with _$RecipeDetailModel {
  const factory RecipeDetailModel({
    required int id,
    @JsonKey(name: 'images') required List<RecipePhotoModel> photoUrls,
    @JsonKey(name: 'title') required String name,
    required int difficulty,
    @JsonKey(name: 'tags') required List<String> categories,
    @JsonKey(name: 'cooking_time_minutes') required int cookingTime,
    @JsonKey(name: 'calories100g') required int calories,
    @JsonKey(name: 'carb100g') required int carbohydrates,
    @JsonKey(name: 'protein100g') required int proteins,
    @JsonKey(name: 'fat100g') required int fats,
    required String description,
    @JsonKey(name: 'servings') required double servingCount,
    required List<RecipeIngredientModel> ingredients,
    required List<RecipeStepModel> steps,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _RecipeDetailModel;

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailModelFromJson(json);
}
