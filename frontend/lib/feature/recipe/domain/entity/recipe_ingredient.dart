import 'package:cookify/feature/recipe/domain/entity/ingredient.dart';
import 'package:equatable/equatable.dart';

class RecipeIngredient extends Equatable {
  const RecipeIngredient({required this.ingredient, required this.quantity});

  final Ingredient ingredient;
  final int quantity;

  @override
  List<Object?> get props => [ingredient, quantity];
}
