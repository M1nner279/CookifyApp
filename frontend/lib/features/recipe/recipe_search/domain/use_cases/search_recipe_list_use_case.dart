import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_search/domain/repositories/recipe_search_repository.dart';

class SearchRecipeListUseCase {
  SearchRecipeListUseCase(this._repository);

  final RecipeSearchRepository _repository;

  Future<Result<List<RecipePreviewEntity>>> call(
    SearchRecipeListPayload payload,
  ) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<List<RecipePreviewEntity>> execute(
    SearchRecipeListPayload payload,
  ) async {
    return await _repository.searchRecipeList(payload);
  }
}
