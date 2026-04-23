import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';
import 'package:cookify/features/recipe/recipe_form/domain/repositories/recipe_form_repository.dart';

class PublishRecipeUseCase {
  PublishRecipeUseCase(this._repository);

  final RecipeFormRepository _repository;

  Future<Result<void>> call(PublishRecipePayload payload) async {
    try {
      await _repository.publishRecipe(payload);
      return const Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
