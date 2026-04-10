import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_step_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe_step.dart';

abstract class RecipeStepMapper {
  static RecipeStep fromDto(RecipeStepDto dto) => RecipeStep(
    photoUrl: dto.imageUrl,
    name: dto.title ?? '',
    description: dto.description,
  );

  static RecipeStepDto toDto(RecipeStep step) => RecipeStepDto(
    imageUrl: step.photoUrl!,
    title: step.name,
    description: step.description,
    id: 0,
  );
}
