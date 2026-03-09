import 'package:cookify/feature/recipe/config/enum/recipe_difficulty.dart';
import 'package:cookify/feature/recipe/domain/entity/category.dart';
import 'package:cookify/feature/recipe/domain/entity/cpfc.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe_ingredient.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe_step.dart';
import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  const Recipe({
    required this.id,
    required this.creator,
    required this.photoUrls,
    required this.name,
    required this.categories,
    required this.cookingTime,
    required this.difficulty,
    required this.cpfc,
    this.description,
    required this.ingredients,
    required this.steps,
  });

  final String id;
  final dynamic creator;
  final List<String> photoUrls;
  final String name;
  final List<Category> categories;
  final int cookingTime;
  final RecipeDifficulty difficulty;
  final Cpfc cpfc;
  final String? description;
  final List<RecipeIngredient> ingredients;
  final List<RecipeStep> steps;

  @override
  List<Object?> get props => [
    id,
    creator,
    photoUrls,
    name,
    categories,
    cookingTime,
    difficulty,
    cpfc,
    description,
    ingredients,
    steps,
  ];
}
