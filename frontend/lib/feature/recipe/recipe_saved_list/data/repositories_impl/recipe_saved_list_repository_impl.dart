import 'package:cookify/feature/recipe/recipe_saved_list/data/data_sources/recipe_saved_list_local_data_source.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/mappers/saved_recipe_preview_mapper.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/entities/saved_recipe_preview_entity.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/repositories/recipe_saved_list_repository.dart';

class RecipeSavedListRepositoryImpl implements RecipeSavedListRepository {
  RecipeSavedListRepositoryImpl({
    required RecipeSavedListLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final RecipeSavedListLocalDataSource _localDataSource;

  @override
  Future<List<SavedRecipePreviewEntity>> getSavedRecipes() async {
    final recipes = await _localDataSource.getSavedRecipes();

    return recipes.map(SavedRecipePreviewMapper.fromDto).toList();
  }
}
