import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_recipe_list_payload.freezed.dart';

@freezed
abstract class GetRecipeListPayload with _$GetRecipeListPayload {
  const factory GetRecipeListPayload({List<RecipePreviewEntity>? recipes}) =
      _GetRecipeListPayload;
}
