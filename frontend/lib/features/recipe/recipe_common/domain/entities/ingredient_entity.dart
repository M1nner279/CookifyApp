import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_entity.freezed.dart';

@freezed
abstract class IngredientEntity with _$IngredientEntity {
  const factory IngredientEntity({
    required String id,
    required String name,
    required CpfcEntity cpfc,
  }) = _IngredientEntity;
}
