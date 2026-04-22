import 'package:cookify/features/recipe/recipe_common/data/models/ingredient_model.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';

abstract class IngredientMapper {
  static IngredientEntity fromModel(IngredientModel model) {
    return IngredientEntity(
      id: model.id.toString(),
      name: model.name,
      cpfc: CpfcEntity(
        carbohydrates: model.carbohydrates,
        proteins: model.proteins,
        fats: model.fats,
        calories: model.calories,
      ),
    );
  }
}
