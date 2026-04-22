import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_recipe_list_request.freezed.dart';
part 'search_recipe_list_request.g.dart';

@freezed
abstract class SearchRecipeListRequest with _$SearchRecipeListRequest {
  const factory SearchRecipeListRequest({
    required int? lastId,
    required String name,
    required List<int> difficulties,
    required List<int> categoryIds,
    required int? maxCookingTime,
    required int? minCarbohydrates,
    required int? maxCarbohydrates,
    required int? minProteins,
    required int? maxProteins,
    required int? minFats,
    required int? maxFats,
    required int? minCalories,
    required int? maxCalories,
    required List<int> ingredients,
  }) = _SearchRecipeListRequest;

  factory SearchRecipeListRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRecipeListRequestFromJson(json);
}
