import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_search_form_state.freezed.dart';

@freezed
abstract class RecipeSearchFormState with _$RecipeSearchFormState {
  const factory RecipeSearchFormState({
    @Default([]) List<CategoryEntity> categories,
    @Default([]) List<IngredientEntity> ingredients,
    @Default(false) bool isLoading,
    @Default(true) bool hasMoreCategories,
    @Default(true) bool hasMoreIngredients,
  }) = _RecipeSearchFormState;
}
