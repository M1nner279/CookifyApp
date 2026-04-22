import 'package:cookify/features/recipe/recipe_common/data/models/category_model.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';

abstract class CategoryMapper {
  static CategoryEntity fromModel(CategoryModel model) {
    return CategoryEntity(id: model.id.toString(), name: model.name);
  }
}
