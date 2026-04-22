import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_search_page_args.freezed.dart';

@freezed
abstract class RecipeSearchPageArgs with _$RecipeSearchPageArgs {
  const factory RecipeSearchPageArgs({
    required SearchRecipeListPayload payload,
  }) = _RecipeSearchPageArgs;
}
