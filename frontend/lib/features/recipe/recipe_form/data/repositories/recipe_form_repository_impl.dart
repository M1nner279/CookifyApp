import 'package:cookify/features/recipe/recipe_form/data/data_sources/recipe_form_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_form/domain/payloads/publish_recipe_payload.dart';
import 'package:cookify/features/recipe/recipe_form/domain/repositories/recipe_form_repository.dart';

class RecipeFormRepositoryImpl implements RecipeFormRepository {
  RecipeFormRepositoryImpl({
    required RecipeFormRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final RecipeFormRemoteDataSource _remoteDataSource;

  @override
  Future<void> publishRecipe(PublishRecipePayload payload) async {
    await _remoteDataSource.publishRecipe(payload);
  }
}
