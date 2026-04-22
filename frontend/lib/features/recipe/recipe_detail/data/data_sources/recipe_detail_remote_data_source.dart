import 'package:cookify/features/recipe/recipe_detail/data/models/recipe_detail_model.dart';
import 'package:cookify/features/recipe/recipe_detail/data/requests/get_recipe_detail_request.dart';

abstract interface class RecipeDetailRemoteDataSource {
  Future<RecipeDetailModel> getRecipeDetail(GetRecipeDetailRequest request);
}
