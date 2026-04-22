import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
abstract class IngredientModel with _$IngredientModel {
  const factory IngredientModel({
    required int id,
    required String name,
    @JsonKey(name: 'calories100g') required int calories,
    @JsonKey(name: 'carb100g') required int carbohydrates,
    @JsonKey(name: 'protein100g') required int proteins,
    @JsonKey(name: 'fat100g') required int fats,
  }) = _IngredientModel;

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);
}
