import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_ingredient_dto.freezed.dart';
part 'recipe_ingredient_dto.g.dart';

@freezed
abstract class RecipeIngredientDto with _$RecipeIngredientDto {
  const factory RecipeIngredientDto({
    required int id,
    required String name,
    required double calories100g,
    required double protein100g,
    required double fat100g,
    required double carb100g,
    required int amount,
    required String unit,
  }) = _RecipeIngredientDto;

  factory RecipeIngredientDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientDtoFromJson(json);
}
