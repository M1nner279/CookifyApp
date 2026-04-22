import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_recipe_list_request.freezed.dart';
part 'get_recipe_list_request.g.dart';

@freezed
abstract class GetRecipeListRequest with _$GetRecipeListRequest {
  const factory GetRecipeListRequest({required int? lastId}) =
      _GetRecipeListRequest;

  factory GetRecipeListRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRecipeListRequestFromJson(json);
}
