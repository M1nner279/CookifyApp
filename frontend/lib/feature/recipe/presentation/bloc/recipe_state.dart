import 'package:cookify/core/error/failure.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe.dart';
import 'package:equatable/equatable.dart';

sealed class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object?> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  const RecipeLoaded({
    required this.recipe,
    this.isLoading = false,
    this.failure,
  });

  final Recipe recipe;
  final bool isLoading;
  final Failure? failure;

  @override
  List<Object?> get props => [recipe, isLoading, failure];

  RecipeLoaded copyWith({Recipe? recipe, bool? isLoading, Failure? failure}) {
    return RecipeLoaded(
      recipe: recipe ?? this.recipe,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }
}

class RecipeError extends RecipeState {
  const RecipeError({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];

  RecipeError copyWith({Failure? failure}) {
    return RecipeError(failure: failure ?? this.failure);
  }
}
