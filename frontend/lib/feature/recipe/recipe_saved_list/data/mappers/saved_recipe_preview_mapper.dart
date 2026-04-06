import 'package:cookify/feature/recipe/recipe_common/data/mappers/category_mapper.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/models/saved_recipe_preview_dto.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/entities/saved_recipe_preview_entity.dart';

abstract class SavedRecipePreviewMapper {
  static SavedRecipePreviewEntity fromDto(SavedRecipePreviewDto dto) =>
      SavedRecipePreviewEntity(
        id: dto.id,
        serverId: dto.serverId,
        isPublished: dto.isPublished,
        photoUrl: dto.photoUrl,
        difficulty: dto.difficulty,
        name: dto.name,
        cookingTime: dto.cookingTime,
        categories: dto.categories.map(CategoryMapper.fromDto).toList(),
      );
}
