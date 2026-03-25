import 'package:cookify/feature/home/domain/usecase/get_recipe_list.dart';
import 'package:cookify/feature/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required GetRecipeList getRecipeList})
    : _getRecipeList = getRecipeList,
      super(HomeInitial());

  final GetRecipeList _getRecipeList;

  Future<void> getRecipeList() async {
    emit(HomeLoading());

    final recipesOrFailure = await _getRecipeList();

    if (!isClosed) {
      emit(
        recipesOrFailure.fold(
          (failure) => HomeError(failure: failure),
          (recipes) => HomeLoaded(recipes: recipes),
        ),
      );
    }
  }
}
