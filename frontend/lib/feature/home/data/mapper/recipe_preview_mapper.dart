import 'package:cookify/feature/home/data/model/recipe_preview_dto.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/entity/recipe_preview.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';

abstract class RecipePreviewMapper {
  static RecipePreview fromDto(RecipePreviewDto dto) => RecipePreview(
    id: dto.id.toString(),
    photoUrls: [dto.imageUrl],
    name: dto.title,
    difficulty: RecipeDifficulty.values[dto.difficulty],
    categories: dto.tags.map((e) => CategoryEntity(name: e)).toList(),
    cookingTime: dto.cookingTime,
    servingCount: dto.servings,
  );
}
