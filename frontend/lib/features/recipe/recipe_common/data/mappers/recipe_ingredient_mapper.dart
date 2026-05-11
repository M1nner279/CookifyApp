import 'package:cookify/features/recipe/recipe_common/data/models/recipe_ingredient_model.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_ingredient_entity.dart';

abstract class RecipeIngredientMapper {
  static RecipeIngredientEntity fromModel(RecipeIngredientModel model) {
    return RecipeIngredientEntity(
      name: model.name,
      cpfc: CpfcEntity(
        carbohydrates: model.carbohydrates,
        proteins: model.proteins,
        fats: model.fats,
        calories: model.calories,
      ),
      amount: model.amount,
      unit: model.unit!,
    );
  }
}
