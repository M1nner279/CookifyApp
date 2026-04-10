import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_ingredient_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/cpfc.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe_ingredient.dart';

abstract class RecipeIngredientMapper {
  static RecipeIngredient fromDto(RecipeIngredientDto dto) => RecipeIngredient(
    name: dto.name,
    cpfc: Cpfc(
      carbohydrates: dto.carb100g.toInt(),
      proteins: dto.protein100g.toInt(),
      fats: dto.fat100g.toInt(),
      calories: dto.calories100g.toInt(),
    ),
    amount: dto.amount.toDouble(),
    unit: dto.unit,
  );

  static RecipeIngredientDto toDto(RecipeIngredient ingredient) => RecipeIngredientDto(
    name: ingredient.name,
    carb100g: ingredient.cpfc.carbohydrates.toDouble(),
    protein100g: ingredient.cpfc.proteins.toDouble(),
    fat100g: ingredient.cpfc.fats.toDouble(),
    calories100g: ingredient.cpfc.calories.toDouble(),
    amount: ingredient.amount.toInt(),
    unit: ingredient.unit, id: 0,
  );
}
