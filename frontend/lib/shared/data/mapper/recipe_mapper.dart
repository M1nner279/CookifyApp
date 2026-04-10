import 'package:cookify/feature/recipe/recipe_common/data/models/image_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_ingredient_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_step_dto.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/data/mapper/recipe_ingredient_mapper.dart';
import 'package:cookify/shared/data/mapper/recipe_step_mapper.dart';
import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/cpfc.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe.dart';

abstract class RecipeMapper {
  static Recipe fromDto(RecipeDto dto) => Recipe(
    id: dto.id.toString(),
    creator: null,
    photoUrls: dto.images.map((e) => e.url).toList(),
    name: dto.title,
    difficulty: RecipeDifficulty.values[dto.difficulty],
    categories: dto.tags.map((e) => CategoryEntity(name: e)).toList(),
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

  static RecipeDto toDto(Recipe recipe) => RecipeDto(
    id: int.parse(recipe.id!),
    title: recipe.name,
    images: recipe.photoUrls.map((e) => ImageDto(url: e)).toList(),
    difficulty: recipe.difficulty.index,
    tags: recipe.categories.map((e) => e.name).toList(),
    cookingTime: recipe.cookingTime,
    carb100g: recipe.cpfc.carbohydrates,
    protein100g: recipe.cpfc.proteins,
    fat100g: recipe.cpfc.fats,
    calories100g: recipe.cpfc.calories,
    description: recipe.description,
    servings: recipe.servingCount,
    ingredients: recipe.ingredients
        .map((e) => RecipeIngredientMapper.toDto(e))
        .toList(),
    steps: recipe.steps.map((e) => RecipeStepMapper.toDto(e)).toList(),
  );
}
