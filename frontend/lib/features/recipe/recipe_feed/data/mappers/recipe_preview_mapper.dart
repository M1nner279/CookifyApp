import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_feed/data/models/recipe_preview_model.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';

abstract class RecipePreviewMapper {
  static RecipePreviewEntity fromModel(RecipePreviewModel model) {
    return RecipePreviewEntity(
      id: model.id.toString(),
      name: model.name,
      photoUrl: model.photoUrl,
      cookingTime: model.cookingTime,
      servingCount: model.servingCount,
      difficulty: RecipeDifficulty.values[model.difficulty],
      categories: model.categories,
    );
  }
}
