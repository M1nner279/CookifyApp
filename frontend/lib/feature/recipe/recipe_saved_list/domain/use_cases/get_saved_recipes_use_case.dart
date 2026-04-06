import 'package:cookify/feature/recipe/recipe_saved_list/domain/entities/saved_recipe_preview_entity.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/repositories/recipe_saved_list_repository.dart';

class GetSavedRecipesUseCase {
  GetSavedRecipesUseCase({required RecipeSavedListRepository repository})
    : _repository = repository;

  final RecipeSavedListRepository _repository;

  Future<List<SavedRecipePreviewEntity>> call() {
    return _repository.getSavedRecipes();
  }
}
