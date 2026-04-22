import 'package:cookify/features/recipe/recipe_feed/data/models/recipe_preview_model.dart';
import 'package:cookify/features/recipe/recipe_search/data/requests/search_recipe_list_request.dart';

abstract interface class RecipeSearchRemoteDataSource {
  Future<List<RecipePreviewModel>> searchRecipeList(
    SearchRecipeListRequest request,
  );
}
