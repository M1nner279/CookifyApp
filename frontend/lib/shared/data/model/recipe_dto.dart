import 'package:cookify/shared/data/model/image_dto.dart';
import 'package:cookify/shared/data/model/recipe_ingredient_dto.dart';
import 'package:cookify/shared/data/model/recipe_step_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_dto.freezed.dart';
part 'recipe_dto.g.dart';

@freezed
abstract class RecipeDto with _$RecipeDto {
  const factory RecipeDto({
    int? id,
    required String title,
    @JsonKey(name: 'cooking_time_minutes') required int cookingTime,
    required double servings,
    required int calories100g,
    required int protein100g,
    required int fat100g,
    required int carb100g,
    required String description,
    required int difficulty,
    required List<ImageDto> images,
    required List<RecipeStepDto> steps,
    required List<RecipeIngredientDto> ingredients,
    required List<String> tags,
  }) = _RecipeDto;

  factory RecipeDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeDtoFromJson(json);
}
