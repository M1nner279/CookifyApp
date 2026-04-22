import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/payloads/get_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/use_cases/get_recipe_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/bloc/recipe_feed_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeFeedCubit extends Cubit<RecipeFeedState> {
  RecipeFeedCubit({required GetRecipeListUseCase getRecipeListUseCase})
    : _getRecipeListUseCase = getRecipeListUseCase,
      super(const RecipeFeedInitial());

  final GetRecipeListUseCase _getRecipeListUseCase;

  Future<void> getRecipeList() async {
    List<RecipePreviewEntity>? recipes;
    if (state is RecipeFeedLoaded) {
      if (!(state as RecipeFeedLoaded).hasMore) return;

      emit((state as RecipeFeedLoaded).copyWith(isLoading: true));
      recipes = (state as RecipeFeedLoaded).recipes.toList();
    } else {
      emit(RecipeFeedLoading());
      recipes = null;
    }

    final result = await _getRecipeListUseCase(
      GetRecipeListPayload(recipes: recipes),
    );
    if (isClosed) return;

    switch (result) {
      case Success(data: final newRecipes):
        recipes = [...?recipes, ...newRecipes];
        emit(
          RecipeFeedLoaded(
            recipes: recipes,
            isLoading: false,
            hasMore: newRecipes.isNotEmpty,
          ),
        );
        break;
      case Failure():
        emit(RecipeFeedError());
        break;
    }
  }
}
