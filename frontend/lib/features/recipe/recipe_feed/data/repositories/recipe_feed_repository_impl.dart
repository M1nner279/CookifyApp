import 'package:cookify/features/recipe/recipe_feed/data/data_sources/recipe_feed_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_feed/data/mappers/recipe_preview_mapper.dart';
import 'package:cookify/features/recipe/recipe_feed/data/requests/get_recipe_list_request.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/payloads/get_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/repositories/recipe_feed_repository.dart';

class RecipeFeedRepositoryImpl implements RecipeFeedRepository {
  RecipeFeedRepositoryImpl({
    required RecipeFeedRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final RecipeFeedRemoteDataSource _remoteDataSource;

  @override
  Future<List<RecipePreviewEntity>> getRecipeList(
    GetRecipeListPayload payload,
  ) async {
    final lastId = payload.recipes == null
        ? null
        : int.tryParse(payload.recipes!.last.id);
    final recipes = await _remoteDataSource.getRecipeList(
      GetRecipeListRequest(lastId: lastId),
    );

    return recipes.map(RecipePreviewMapper.fromModel).toList();
  }
}
