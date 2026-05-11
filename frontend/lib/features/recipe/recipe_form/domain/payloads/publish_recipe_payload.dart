import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:image_picker/image_picker.dart';

class PublishRecipePayload {
  const PublishRecipePayload({
    required this.name,
    required this.description,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
    required this.difficulty,
    required this.cookingTimeMinutes,
    required this.categories,
    required this.ingredients,
    required this.steps,
    required this.photos,
  });

  final String name;
  final String description;
  final int calories;
  final int proteins;
  final int fats;
  final int carbohydrates;
  final RecipeDifficulty difficulty;
  final int cookingTimeMinutes;
  final List<int> categories;
  final List<PublishRecipeIngredientPayload> ingredients;
  final List<PublishRecipeStepPayload> steps;
  final List<XFile> photos;
}

class PublishRecipeIngredientPayload {
  const PublishRecipeIngredientPayload({
    required this.id,
    required this.amount,
    required this.unit,
  });

  final String id;
  final double amount;
  final String unit;
}

class PublishRecipeStepPayload {
  const PublishRecipeStepPayload({
    required this.title,
    required this.description,
    this.photoPath,
  });

  final String title;
  final String description;
  final String? photoPath;
}
