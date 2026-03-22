import 'package:cookify/core/error/failure.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:equatable/equatable.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.recipes,
    this.isLoading = false,
    this.failure,
  });

  final List<RecipePreview> recipes;
  final bool isLoading;
  final Failure? failure;

  @override
  List<Object?> get props => [recipes, isLoading, failure];

  HomeLoaded copyWith({
    List<RecipePreview>? recipes,
    bool? isLoading,
    Failure? failure,
  }) {
    return HomeLoaded(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }
}

class HomeError extends HomeState {
  const HomeError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];

  HomeError copyWith({Failure? failure}) {
    return HomeError(failure: failure ?? this.failure);
  }
}
