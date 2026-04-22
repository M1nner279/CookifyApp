import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_recipe_detail_request.freezed.dart';

@freezed
abstract class GetRecipeDetailRequest with _$GetRecipeDetailRequest {
  const factory GetRecipeDetailRequest({required int id}) =
      _GetRecipeDetailRequest;
}
