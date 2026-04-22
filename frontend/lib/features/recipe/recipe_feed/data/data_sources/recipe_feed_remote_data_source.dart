import 'package:cookify/features/recipe/recipe_feed/data/models/recipe_preview_model.dart';
import 'package:cookify/features/recipe/recipe_feed/data/requests/get_recipe_list_request.dart';

abstract interface class RecipeFeedRemoteDataSource {
  Future<List<RecipePreviewModel>> getRecipeList(GetRecipeListRequest request);
}
