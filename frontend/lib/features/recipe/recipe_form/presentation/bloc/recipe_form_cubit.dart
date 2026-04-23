import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_step_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_category_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_ingredient_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_category_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_ingredient_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';
import 'package:cookify/features/recipe/recipe_form/domain/use_cases/publish_recipe_use_case.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/bloc/recipe_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RecipeFormCubit extends Cubit<RecipeFormState> {
  RecipeFormCubit({
    required PublishRecipeUseCase publishRecipeUseCase,
    required SearchCategoryListUseCase searchCategoryListUseCase,
    required SearchIngredientListUseCase searchIngredientListUseCase,
  }) : _publishRecipeUseCase = publishRecipeUseCase,
       _searchCategoryListUseCase = searchCategoryListUseCase,
       _searchIngredientListUseCase = searchIngredientListUseCase,
       super(RecipeFormState.initial());

  final PublishRecipeUseCase _publishRecipeUseCase;
  final SearchCategoryListUseCase _searchCategoryListUseCase;
  final SearchIngredientListUseCase _searchIngredientListUseCase;

  void onPhotosChanged(List<XFile> photos) {
    emit(state.copyWith(photos: photos));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onDescriptionChanged(String description) {
    emit(state.copyWith(description: description));
  }

  void onCpfcChanged({int? calories, int? proteins, int? carbs, int? fats}) {
    emit(
      state.copyWith(
        cpfc: CpfcEntity(
          calories: calories ?? state.cpfc.calories,
          proteins: proteins ?? state.cpfc.proteins,
          carbohydrates: carbs ?? state.cpfc.carbohydrates,
          fats: fats ?? state.cpfc.fats,
        ),
      ),
    );
  }

  void onDifficultyChanged(RecipeDifficulty difficulty) {
    emit(state.copyWith(difficulty: difficulty));
  }

  void onCookingTimeChanged(int cookingTime) {
    emit(state.copyWith(cookingTime: cookingTime));
  }

  void onCategoriesChanged(List<CategoryEntity> categories) {
    emit(state.copyWith(categories: categories));
  }

  void onIngredientsChanged(List<RecipeIngredientEntity> ingredients) {
    emit(state.copyWith(ingredients: ingredients));
  }

  void onStepsChanged(List<RecipeStepEntity> steps) {
    emit(state.copyWith(steps: steps));
  }

  Future<void> searchCategoryList(String name) async {
    final result = await _searchCategoryListUseCase(
      SearchCategoryListPayload(
        categories: state.searchedCategories,
        name: name,
      ),
    );
    if (isClosed) return;

    switch (result) {
      case Success(data: final categories):
        emit(state.copyWith(searchedCategories: categories));
        break;
      case Failure():
        break;
    }
  }

  Future<void> searchIngredientList(String name) async {
    final result = await _searchIngredientListUseCase(
      SearchIngredientListPayload(
        ingredients: state.searchedIngredients,
        name: name,
      ),
    );
    if (isClosed) return;

    switch (result) {
      case Success(data: final ingredients):
        emit(state.copyWith(searchedIngredients: ingredients));
        break;
      case Failure():
        break;
    }
  }

  Future<Result<void>> publishRecipe(PublishRecipePayload payload) async {
    emit(state.copyWith(isPublishing: true));
    final result = await _publishRecipeUseCase(payload);
    if (isClosed) return Result.failure(Exception('Cubit closed'));

    emit(state.copyWith(isPublishing: false));
    return result;
  }
}
