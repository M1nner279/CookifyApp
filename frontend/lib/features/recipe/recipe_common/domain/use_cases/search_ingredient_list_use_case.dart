import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_ingredient_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/recipe_common_search_repository.dart';

class SearchIngredientListUseCase {
  SearchIngredientListUseCase(this._repository);

  final RecipeCommonSearchRepository _repository;

  Future<Result<List<IngredientEntity>>> call(
    SearchIngredientListPayload payload,
  ) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<List<IngredientEntity>> execute(
    SearchIngredientListPayload payload,
  ) async {
    return await _repository.searchIngredientList(payload);
  }
}
