import 'package:cookify/features/recipe/recipe_common/data/models/category_model.dart';
import 'package:cookify/features/recipe/recipe_common/data/models/ingredient_model.dart';
import 'package:cookify/features/recipe/recipe_common/data/requests/search_category_list_request.dart';
import 'package:cookify/features/recipe/recipe_common/data/requests/search_ingredient_list_request.dart';

abstract interface class RecipeCommonSearchRemoteDataSource {
  Future<List<CategoryModel>> searchCategoryList(
    SearchCategoryListRequest request,
  );

  Future<List<IngredientModel>> searchIngredientList(
    SearchIngredientListRequest request,
  );
}
