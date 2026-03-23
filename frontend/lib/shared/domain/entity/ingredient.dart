import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient.freezed.dart';

@freezed
abstract class Ingredient with _$Ingredient {
  const factory Ingredient({
    String? id,
    required String name,
    required Cpfc cpfc,
  }) = _Ingredient;
}
