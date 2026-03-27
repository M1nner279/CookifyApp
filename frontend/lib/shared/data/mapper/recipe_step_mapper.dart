import 'package:cookify/shared/data/model/recipe_step_dto.dart';
import 'package:cookify/shared/domain/entity/recipe_step.dart';

abstract class RecipeStepMapper {
  static RecipeStep fromDto(RecipeStepDto dto) => RecipeStep(
    photoUrl: dto.imageUrl,
    name: dto.title ?? '',
    description: dto.description,
  );
}
