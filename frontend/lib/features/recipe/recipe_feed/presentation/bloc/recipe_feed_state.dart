import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_feed_state.freezed.dart';

@freezed
sealed class RecipeFeedState with _$RecipeFeedState {
  const factory RecipeFeedState.initial() = RecipeFeedInitial;

  const factory RecipeFeedState.loading() = RecipeFeedLoading;

  const factory RecipeFeedState.loaded({
    required List<RecipePreviewEntity> recipes,
    @Default(false) bool isLoading,
    @Default(true) bool hasMore,
  }) = RecipeFeedLoaded;

  const factory RecipeFeedState.error() = RecipeFeedError;
}
