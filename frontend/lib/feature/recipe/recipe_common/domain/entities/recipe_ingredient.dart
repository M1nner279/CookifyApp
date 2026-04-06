import 'package:cookify/feature/recipe/recipe_common/domain/entities/cpfc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_ingredient.freezed.dart';

@freezed
abstract class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    required String name,
    required Cpfc cpfc,
    required double amount,
    required String unit,
  }) = _RecipeIngredient;
}
