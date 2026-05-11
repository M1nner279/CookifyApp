import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_search/domain/use_cases/search_recipe_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeSearchCubit extends Cubit<RecipeSearchState> {
  RecipeSearchCubit({
    required SearchRecipeListPayload payload,
    required SearchRecipeListUseCase searchRecipeListUseCase,
  }) : _payload = payload,
       _searchRecipeListUseCase = searchRecipeListUseCase,
       super(const RecipeSearchInitial());

  final SearchRecipeListPayload _payload;
  final SearchRecipeListUseCase _searchRecipeListUseCase;

  Future<void> searchRecipeList() async {
    List<RecipePreviewEntity>? recipes;
    emit(RecipeSearchLoading());
    recipes = null;

    final result = await _searchRecipeListUseCase(_payload);
    if (isClosed) return;

    switch (result) {
      case Success(data: final newRecipes):
        recipes = [...?recipes, ...newRecipes];
        emit(
          RecipeSearchLoaded(
            recipes: recipes,
            isLoading: false,
            hasMore: false,
          ),
        );
        break;
      case Failure():
        emit(RecipeSearchError());
        break;
    }
  }
}
