import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/payloads/get_recipe_detail_payload.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/use_cases/get_recipe_detail_use_case.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/bloc/recipe_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeDetailCubit extends Cubit<RecipeDetailState> {
  RecipeDetailCubit({
    required String id,
    required GetRecipeDetailUseCase getRecipeDetailUseCase,
  }) : _id = id,
       _getRecipeDetailUseCase = getRecipeDetailUseCase,
       super(const RecipeDetailInitial());

  final String _id;
  final GetRecipeDetailUseCase _getRecipeDetailUseCase;

  Future<void> getRecipeDetail() async {
    emit(const RecipeDetailLoading());

    final result = await _getRecipeDetailUseCase(
      GetRecipeDetailPayload(id: _id),
    );
    if (isClosed) return;

    switch (result) {
      case Success(data: final recipeDetail):
        emit(RecipeDetailLoaded(recipe: recipeDetail));
      case Failure():
        emit(RecipeDetailError());
    }
  }
}
