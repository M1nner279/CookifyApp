import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_ingredient_model.freezed.dart';
part 'recipe_ingredient_model.g.dart';

@freezed
abstract class RecipeIngredientModel with _$RecipeIngredientModel {
  const factory RecipeIngredientModel({
    required int id,
    required String name,
    @JsonKey(name: 'calories100g') required int calories,
    @JsonKey(name: 'carb100g') required int carbohydrates,
    @JsonKey(name: 'protein100g') required int proteins,
    @JsonKey(name: 'fat100g') required int fats,
    required double amount,
    required String? unit,
  }) = _RecipeIngredientModel;

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientModelFromJson(json);
}
