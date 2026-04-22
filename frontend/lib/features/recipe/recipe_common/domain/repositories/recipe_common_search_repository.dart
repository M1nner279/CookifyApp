import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_category_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_ingredient_list_payload.dart';

abstract interface class RecipeCommonSearchRepository {
  Future<List<CategoryEntity>> searchCategoryList(
    SearchCategoryListPayload payload,
  );

  Future<List<IngredientEntity>> searchIngredientList(
    SearchIngredientListPayload payload,
  );
}
