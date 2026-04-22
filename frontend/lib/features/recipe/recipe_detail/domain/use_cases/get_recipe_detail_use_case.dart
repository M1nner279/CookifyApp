import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/payloads/get_recipe_detail_payload.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/repositories/recipe_detail_repository.dart';

class GetRecipeDetailUseCase {
  GetRecipeDetailUseCase(this._repository);

  final RecipeDetailRepository _repository;

  Future<Result<RecipeDetailEntity>> call(
    GetRecipeDetailPayload payload,
  ) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<RecipeDetailEntity> execute(GetRecipeDetailPayload payload) async {
    return await _repository.getRecipeDetail(payload);
  }
}
