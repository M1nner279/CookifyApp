import 'package:cookify/feature/recipe/recipe_common/data/mappers/category_mapper.dart';
import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/models/saved_recipe_preview_dto.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/entities/saved_recipe_preview_entity.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:flutter/foundation.dart';

abstract class SavedRecipePreviewMapper {
  static SavedRecipePreviewEntity fromDto(RecipeDto dto) =>
      SavedRecipePreviewEntity(
        id: '',
        serverId: dto.id.toString(),
        isPublished: true,
        photoUrl: dto.images.first.url,
        difficulty: RecipeDifficulty.values[dto.difficulty],
        name: dto.title,
        cookingTime: dto.cookingTime,
        categories: dto.tags.map((e) => CategoryEntity(name: e)).toList(),
      );
}
