import 'package:cookify/features/recipe/recipe_common/data/data_sources/recipe_common_search_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_common/data/mappers/category_mapper.dart';
import 'package:cookify/features/recipe/recipe_common/data/mappers/ingredient_mapper.dart';
import 'package:cookify/features/recipe/recipe_common/data/requests/search_category_list_request.dart';
import 'package:cookify/features/recipe/recipe_common/data/requests/search_ingredient_list_request.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_category_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/payloads/search_ingredient_list_payload.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/recipe_common_search_repository.dart';

class RecipeCommonSearchRepositoryImpl implements RecipeCommonSearchRepository {
  RecipeCommonSearchRepositoryImpl({
    required RecipeCommonSearchRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final RecipeCommonSearchRemoteDataSource _remoteDataSource;

  @override
  Future<List<CategoryEntity>> searchCategoryList(
    SearchCategoryListPayload payload,
  ) async {
    final lastId = payload.categories == null || payload.categories!.isEmpty
        ? null
        : int.tryParse(payload.categories!.last.id);
    final categories = await _remoteDataSource.searchCategoryList(
      SearchCategoryListRequest(lastId: lastId, name: payload.name),
    );

    return categories.map(CategoryMapper.fromModel).toList();
  }

  @override
  Future<List<IngredientEntity>> searchIngredientList(
    SearchIngredientListPayload payload,
  ) async {
    final lastId = payload.ingredients == null || payload.ingredients!.isEmpty
        ? null
        : int.tryParse(payload.ingredients!.last.id);
    final ingredients = await _remoteDataSource.searchIngredientList(
      SearchIngredientListRequest(lastId: lastId, name: payload.name),
    );

    return ingredients.map(IngredientMapper.fromModel).toList();
  }
}
