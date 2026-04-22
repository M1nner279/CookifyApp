import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_category_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_ingredient_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_category_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_ingredient_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSearchFormCubit extends Cubit<RecipeSearchFormState> {
  RecipeSearchFormCubit({
    required SearchCategoryListUseCase searchCategoryListUseCase,
    required SearchIngredientListUseCase searchIngredientListUseCase,
  }) : _searchCategoryListUseCase = searchCategoryListUseCase,
       _searchIngredientListUseCase = searchIngredientListUseCase,
       super(const RecipeSearchFormState());

  final SearchCategoryListUseCase _searchCategoryListUseCase;
  final SearchIngredientListUseCase _searchIngredientListUseCase;

  Future<void> searchCategoryList(String name) async {
    final result = await _searchCategoryListUseCase(
      SearchCategoryListPayload(categories: state.categories, name: name),
    );
    if (isClosed) return;

    switch (result) {
      case Success(data: final categories):
        emit(state.copyWith(categories: categories));
        break;
      case Failure():
        break;
    }
  }

  Future<void> searchIngredientList(String name) async {
    final result = await _searchIngredientListUseCase(
      SearchIngredientListPayload(ingredients: state.ingredients, name: name),
    );
    if (isClosed) return;

    switch (result) {
      case Success(data: final ingredients):
        emit(state.copyWith(ingredients: ingredients));
        break;
      case Failure():
        break;
    }
  }
}
