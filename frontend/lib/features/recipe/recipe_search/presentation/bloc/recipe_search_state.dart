import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_search_state.freezed.dart';

@freezed
sealed class RecipeSearchState with _$RecipeSearchState {
  const factory RecipeSearchState.initial() = RecipeSearchInitial;

  const factory RecipeSearchState.loading() = RecipeSearchLoading;

  const factory RecipeSearchState.loaded({
    required List<RecipePreviewEntity> recipes,
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
  }) = RecipeSearchLoaded;

  const factory RecipeSearchState.error() = RecipeSearchError;
}
