import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_ingredient_entity.freezed.dart';

@freezed
abstract class RecipeIngredientEntity with _$RecipeIngredientEntity {
  const factory RecipeIngredientEntity({
    required String name,
    required CpfcEntity cpfc,
    required double amount,
    required String unit,
  }) = _RecipeIngredientEntity;
}
