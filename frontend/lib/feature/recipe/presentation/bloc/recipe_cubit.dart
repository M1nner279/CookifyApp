import 'package:cookify/feature/recipe/domain/usecase/get_recipe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit({required this.id, required GetRecipe getRecipe})
    : _getRecipe = getRecipe,
      super(RecipeInitial());

  final String id;
  final GetRecipe _getRecipe;

  Future<void> getRecipe() async {
    emit(RecipeLoading());

    final recipeOrFailure = await _getRecipe(id);

    if (!isClosed) {
      emit(
        recipeOrFailure.fold(
          (failure) => RecipeError(failure: failure),
          (recipe) => RecipeLoaded(recipe: recipe),
        ),
      );
    }
  }
}
