import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_ingredient_list_request.freezed.dart';
part 'search_ingredient_list_request.g.dart';

@freezed
abstract class SearchIngredientListRequest with _$SearchIngredientListRequest {
  const factory SearchIngredientListRequest({
    required int? lastId,
    required String name,
  }) = _SearchIngredientListRequest;

  factory SearchIngredientListRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchIngredientListRequestFromJson(json);
}
