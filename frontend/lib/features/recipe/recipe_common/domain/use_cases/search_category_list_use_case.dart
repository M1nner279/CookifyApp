import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_category_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/recipe_common_search_repository.dart';

class SearchCategoryListUseCase {
  SearchCategoryListUseCase(this._repository);

  final RecipeCommonSearchRepository _repository;

  Future<Result<List<CategoryEntity>>> call(
    SearchCategoryListPayload payload,
  ) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<List<CategoryEntity>> execute(
    SearchCategoryListPayload payload,
  ) async {
    return await _repository.searchCategoryList(payload);
  }
}
