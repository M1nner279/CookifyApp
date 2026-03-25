import 'package:cookify/config/error/failure.dart';
import 'package:cookify/shared/domain/entity/recipe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_state.freezed.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState.initial() = RecipeInitial;
  
  const factory RecipeState.loading() = RecipeLoading;
  
  const factory RecipeState.loaded({
    required Recipe recipe,
    @Default(false) bool isLoading,
    Failure? failure,
  }) = RecipeLoaded;
  
  const factory RecipeState.error({
    required Failure failure,
  }) = RecipeError;
}

