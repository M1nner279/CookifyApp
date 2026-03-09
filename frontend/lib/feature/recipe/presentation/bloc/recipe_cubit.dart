import 'package:cookify/feature/recipe/domain/usecase/get_recipe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit({required String id, required GetRecipe getRecipe})
    : _id = id,
      _getRecipe = getRecipe,
      super(RecipeInitial());

  final String _id;
  final GetRecipe _getRecipe;

  Future<void> getRecipe() async {
    emit(RecipeLoading());

    final recipeOrFailure = await _getRecipe(_id);

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
