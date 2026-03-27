import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/data/mapper/recipe_ingredient_mapper.dart';
import 'package:cookify/shared/data/mapper/recipe_step_mapper.dart';
import 'package:cookify/shared/data/model/recipe_dto.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:cookify/shared/domain/entity/recipe.dart';

abstract class RecipeMapper {
  static Recipe fromDto(RecipeDto dto) => Recipe(
    creator: null,
    photoUrls: dto.images.map((e) => e.url).toList(),
    name: dto.title,
    difficulty: RecipeDifficulty.values[dto.difficulty],
    categories: dto.tags.map((e) => Category(name: e)).toList(),
    cookingTime: dto.cookingTime,
    cpfc: Cpfc(
      carbohydrates: dto.carb100g,
      proteins: dto.protein100g,
      fats: dto.fat100g,
      calories: dto.calories100g,
    ),
    description: dto.description,
    servingCount: dto.servings,
    ingredients: dto.ingredients
        .map((e) => RecipeIngredientMapper.fromDto(e))
        .toList(),
    steps: dto.steps.map((e) => RecipeStepMapper.fromDto(e)).toList(),
  );
}
