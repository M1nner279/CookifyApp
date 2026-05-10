import 'dart:async'; // Добавляем для работы с Timer
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
  })  : _searchCategoryListUseCase = searchCategoryListUseCase,
        _searchIngredientListUseCase = searchIngredientListUseCase,
        super(const RecipeSearchFormState());

  final SearchCategoryListUseCase _searchCategoryListUseCase;
  final SearchIngredientListUseCase _searchIngredientListUseCase;

  // Таймеры для debounce
  Timer? _categoryDebounce;
  Timer? _ingredientDebounce;

  // Категории
  void searchCategoryList(String name) {
    // Отменяем предыдущий таймер, если пользователь продолжает печатать
    _categoryDebounce?.cancel();

    _categoryDebounce = Timer(const Duration(milliseconds: 500), () async {
      final result = await _searchCategoryListUseCase(
        SearchCategoryListPayload(categories: state.categories, name: name),
      );
      
      if (isClosed) return;

      if (result is Success) {
        emit(state.copyWith(categories: (result as Success).data));
      }
    });
  }

  // Ингредиенты
  void searchIngredientList(String name) {
    _ingredientDebounce?.cancel();

    _ingredientDebounce = Timer(const Duration(milliseconds: 500), () async {
      final result = await _searchIngredientListUseCase(
        SearchIngredientListPayload(ingredients: state.ingredients, name: name),
      );

      if (isClosed) return;

      if (result is Success) {
        emit(state.copyWith(ingredients: (result as Success).data));
      }
    });
  }

  @override
  Future<void> close() {
    _categoryDebounce?.cancel();
    _ingredientDebounce?.cancel();
    return super.close();
  }
}