import 'package:cookify/shared/data/model/recipe_ingredient_dto.dart';
import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:cookify/shared/domain/entity/recipe_ingredient.dart';

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
}
