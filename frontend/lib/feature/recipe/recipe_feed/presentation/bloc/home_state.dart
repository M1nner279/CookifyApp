import 'package:cookify/config/error/failure.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/entity/recipe_preview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = HomeInitial;
  
  const factory HomeState.loading() = HomeLoading;
  
  const factory HomeState.loaded({
    required List<RecipePreview> recipes,
    @Default(false) bool isLoading,
    Failure? failure,
  }) = HomeLoaded;
  
  const factory HomeState.error({
    required Failure failure,
  }) = HomeError;
}
