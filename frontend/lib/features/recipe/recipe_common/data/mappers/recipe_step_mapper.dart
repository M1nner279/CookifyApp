import 'package:cookify/features/recipe/recipe_common/data/models/recipe_step_model.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_step_entity.dart';

abstract class RecipeStepMapper {
  static RecipeStepEntity fromModel(RecipeStepModel model) {
    return RecipeStepEntity(
      id: model.id.toString(),
      name: model.name,
      photoUrl: model.photoUrl,
      description: model.description,
    );
  }
}
