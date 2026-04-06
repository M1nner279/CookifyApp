import 'package:cookify/feature/recipe/recipe_common/data/models/category_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/category.dart';

abstract class CategoryMapper {
  static CategoryEntity fromDto(CategoryDto dto) =>
      CategoryEntity(id: dto.id, name: dto.name);
}
