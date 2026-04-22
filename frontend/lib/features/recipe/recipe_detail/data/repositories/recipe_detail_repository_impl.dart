import 'package:cookify/features/recipe/recipe_detail/data/data_sources/recipe_detail_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_detail/data/mappers/recipe_detail_mapper.dart';
import 'package:cookify/features/recipe/recipe_detail/data/requests/get_recipe_detail_request.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/payloads/get_recipe_detail_payload.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/repositories/recipe_detail_repository.dart';

class RecipeDetailRepositoryImpl implements RecipeDetailRepository {
  RecipeDetailRepositoryImpl({
    required RecipeDetailRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final RecipeDetailRemoteDataSource _remoteDataSource;

  @override
  Future<RecipeDetailEntity> getRecipeDetail(
    GetRecipeDetailPayload payload,
  ) async {
    final id = int.parse(payload.id);
    final recipe = await _remoteDataSource.getRecipeDetail(
      GetRecipeDetailRequest(id: id),
    );

    return RecipeDetailMapper.fromModel(recipe);
  }
}
