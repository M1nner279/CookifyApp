import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_recipe_detail_payload.freezed.dart';

@freezed
abstract class GetRecipeDetailPayload with _$GetRecipeDetailPayload {
  const factory GetRecipeDetailPayload({required String id}) =
      _GetRecipeDetailPayload;
}
