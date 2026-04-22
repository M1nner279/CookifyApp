import 'package:cookify/features/recipe/recipe_common/data/data_sources/recipe_common_search_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_common/data/data_sources/recipe_common_search_remote_data_source_impl.dart';
import 'package:cookify/features/recipe/recipe_common/data/repositories/recipe_common_search_repository_impl.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/recipe_common_search_repository.dart';
import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_category_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_ingredient_list_use_case.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeCommonDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<RecipeCommonSearchRemoteDataSource>(
        () => RecipeCommonSearchRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<RecipeCommonSearchRepository>(
        () => RecipeCommonSearchRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => SearchCategoryListUseCase(getIt()))
      ..registerFactory(() => SearchIngredientListUseCase(getIt()));
  }
}
