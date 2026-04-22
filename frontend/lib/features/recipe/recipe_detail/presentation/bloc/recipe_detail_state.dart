import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_detail_state.freezed.dart';

@freezed
sealed class RecipeDetailState with _$RecipeDetailState {
  const factory RecipeDetailState.initial() = RecipeDetailInitial;

  const factory RecipeDetailState.loading() = RecipeDetailLoading;

  const factory RecipeDetailState.loaded({required RecipeDetailEntity recipe}) =
      RecipeDetailLoaded;

  const factory RecipeDetailState.error() = RecipeDetailError;
}
