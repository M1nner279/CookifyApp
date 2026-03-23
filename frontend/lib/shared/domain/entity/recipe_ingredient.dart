import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_ingredient.freezed.dart';

@freezed
abstract class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    required String name,
    required Cpfc cpfc,
    required double quantity,
    required String unit,
  }) = _RecipeIngredient;
}
