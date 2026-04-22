import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/payloads/get_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/repositories/recipe_feed_repository.dart';

class GetRecipeListUseCase {
  GetRecipeListUseCase(this._repository);

  final RecipeFeedRepository _repository;

  Future<Result<List<RecipePreviewEntity>>> call(
    GetRecipeListPayload payload,
  ) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<List<RecipePreviewEntity>> execute(
    GetRecipeListPayload payload,
  ) async {
    return await _repository.getRecipeList(payload);
  }
}
