import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:equatable/equatable.dart';

class RecipePreview extends Equatable {
  const RecipePreview({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.categories,
    required this.cookingTime,
    required this.difficulty,
  });

  final String id;
  final String photoUrl;
  final String name;
  final List<Category> categories;
  final int cookingTime;
  final RecipeDifficulty difficulty;

  @override
  List<Object?> get props => [
    id,
    photoUrl,
    name,
    categories,
    cookingTime,
    difficulty,
  ];
}
