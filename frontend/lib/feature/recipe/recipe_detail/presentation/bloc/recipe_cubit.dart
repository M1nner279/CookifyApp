import 'package:cookify/feature/recipe/recipe_common/domain/use_cases/save_recipe.dart';
import 'package:cookify/feature/recipe/recipe_detail/domain/usecase/get_recipe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/bloc/recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit({
    required this.id,
    required GetRecipe getRecipe,
    required SaveRecipe saveRecipe,
  }) : _getRecipe = getRecipe,
       _saveRecipe = saveRecipe,
       super(RecipeInitial());

  final String id;
  final GetRecipe _getRecipe;
  final SaveRecipe _saveRecipe;

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

  Future<void> saveRecipe() async => _saveRecipe((state as RecipeLoaded).recipe);
}
