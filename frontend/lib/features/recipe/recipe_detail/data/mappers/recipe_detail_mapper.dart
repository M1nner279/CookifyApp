import 'package:cookify/features/recipe/recipe_common/data/mappers/recipe_ingredient_mapper.dart';
import 'package:cookify/features/recipe/recipe_common/data/mappers/recipe_step_mapper.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_detail/data/models/recipe_detail_model.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';

abstract class RecipeDetailMapper {
  static RecipeDetailEntity fromModel(RecipeDetailModel model) {
    return RecipeDetailEntity(
      id: model.id.toString(),
      creator: null,
      photoUrls: model.photoUrls.map((e) => e.url).toList(),
      name: model.name,
      difficulty: RecipeDifficulty.values[model.difficulty],
      categories: model.categories
          .map((e) => CategoryEntity(id: '0', name: e))
          .toList(),
      cookingTime: model.cookingTime,
      cpfc: CpfcEntity(
        carbohydrates: model.carbohydrates,
        proteins: model.proteins,
        fats: model.fats,
        calories: model.calories,
      ),
      description: model.description,
      servingCount: model.servingCount,
      ingredients: model.ingredients
          .map(RecipeIngredientMapper.fromModel)
          .toList(),
      steps: model.steps.map(RecipeStepMapper.fromModel).toList(),
    );
  }
}
