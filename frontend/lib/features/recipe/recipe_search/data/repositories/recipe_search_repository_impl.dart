import 'package:cookify/features/recipe/recipe_feed/data/mappers/recipe_preview_mapper.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_search/data/data_sources/recipe_search_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_search/data/requests/search_recipe_list_request.dart';
import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_search/domain/repositories/recipe_search_repository.dart';

class RecipeSearchRepositoryImpl implements RecipeSearchRepository {
  RecipeSearchRepositoryImpl({
    required RecipeSearchRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final RecipeSearchRemoteDataSource _remoteDataSource;

  @override
  Future<List<RecipePreviewEntity>> searchRecipeList(
    SearchRecipeListPayload payload,
  ) async {
    final lastId = payload.recipes == null
        ? null
        : int.tryParse(payload.recipes!.last.id);
    final recipes = await _remoteDataSource.searchRecipeList(
      SearchRecipeListRequest(
        lastId: lastId,
        name: payload.name,
        difficulties: payload.difficulties.map((d) => d.index).toList(),
        categoryIds: payload.categories.map((c) => int.parse(c.id)).toList(),
        maxCookingTime: payload.maxCookingTime,
        minCarbohydrates: payload.minCarbohydrates,
        maxCarbohydrates: payload.maxCarbohydrates,
        minProteins: payload.minProteins,
        maxProteins: payload.maxProteins,
        minFats: payload.minFats,
        maxFats: payload.maxFats,
        minCalories: payload.minCalories,
        maxCalories: payload.maxCalories,
        ingredients: payload.ingredients.map((i) => int.parse(i.id)).toList(),
      ),
    );

    return recipes.map(RecipePreviewMapper.fromModel).toList();
  }
}
