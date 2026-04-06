import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/entities/saved_recipe_preview_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_saved_list_state.freezed.dart';

@freezed
abstract class RecipeSavedListState with _$RecipeSavedListState {
  const factory RecipeSavedListState.initial() = RecipeSavedListInitial;

  const factory RecipeSavedListState.loading() = RecipeSavedListLoading;

  const factory RecipeSavedListState.loaded({
    required List<SavedRecipePreviewEntity> recipes,
    required List<SavedRecipePreviewEntity> filteredRecipes,
    required List<CategoryEntity> categories,
    required List<CategoryEntity> selectedCategories,
  }) = RecipeSavedListLoaded;
}
