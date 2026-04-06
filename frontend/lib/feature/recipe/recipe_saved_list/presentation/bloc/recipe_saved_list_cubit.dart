import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/use_cases/get_saved_recipes_use_case.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/bloc/recipe_saved_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSavedListCubit extends Cubit<RecipeSavedListState> {
  RecipeSavedListCubit({required GetSavedRecipesUseCase getSavedRecipesUseCase})
    : _getSavedRecipesUseCase = getSavedRecipesUseCase,
      super(RecipeSavedListInitial());

  final GetSavedRecipesUseCase _getSavedRecipesUseCase;

  Future<void> getSavedRecipes() async {
    emit(RecipeSavedListLoading());

    final recipes = await _getSavedRecipesUseCase();
    final categories = <CategoryEntity>[];
    for (final recipe in recipes) {
      for (final category in recipe.categories) {
        if (!categories.contains(category)) {
          categories.add(category);
        }
      }
    }

    if (!isClosed) {
      emit(
        RecipeSavedListLoaded(
          recipes: recipes,
          filteredRecipes: recipes,
          categories: categories,
          selectedCategories: categories,
        ),
      );
    }
  }

  Future<void> toggleAllCategory() async {
    final loadedState = state as RecipeSavedListLoaded;

    emit(
      loadedState.copyWith(
        filteredRecipes: loadedState.recipes.toList(),
        selectedCategories: loadedState.categories,
      ),
    );
  }

  Future<void> toggleCategory(CategoryEntity category) async {
    final loadedState = state as RecipeSavedListLoaded;

    final categories = loadedState.categories.toList();
    final selectedCategories = loadedState.selectedCategories.toList();
    if (categories.length == selectedCategories.length) {
      selectedCategories.clear();
      selectedCategories.add(category);
    } else {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    }

    emit(
      loadedState.copyWith(
        filteredRecipes: loadedState.recipes
            .where(
              (recipe) => selectedCategories.every(
                (category) => recipe.categories.contains(category),
              ),
            )
            .toList(),
        selectedCategories: selectedCategories,
      ),
    );
  }
}
