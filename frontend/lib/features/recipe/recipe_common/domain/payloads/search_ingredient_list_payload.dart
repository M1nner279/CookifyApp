import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_ingredient_list_payload.freezed.dart';

@freezed
abstract class SearchIngredientListPayload with _$SearchIngredientListPayload {
  const factory SearchIngredientListPayload({
    required List<IngredientEntity>? ingredients,
    required String name,
  }) = _SearchIngredientListPayload;
}
