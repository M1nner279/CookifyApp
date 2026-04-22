import 'package:cookify/features/recipe/recipe_search/data/data_sources/recipe_search_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_search/data/data_sources/recipe_search_remote_data_source_impl.dart';
import 'package:cookify/features/recipe/recipe_search/data/repositories/recipe_search_repository_impl.dart';
import 'package:cookify/features/recipe/recipe_search/domain/payloads/search_recipe_list_payload.dart';
import 'package:cookify/features/recipe/recipe_search/domain/repositories/recipe_search_repository.dart';
import 'package:cookify/features/recipe/recipe_search/domain/use_cases/search_recipe_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_cubit.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/bloc/recipe_search_form_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeSearchDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<RecipeSearchRemoteDataSource>(
        () => RecipeSearchRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<RecipeSearchRepository>(
        () => RecipeSearchRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => SearchRecipeListUseCase(getIt()))
      ..registerFactory(
        () => RecipeSearchFormCubit(
          searchCategoryListUseCase: getIt(),
          searchIngredientListUseCase: getIt(),
        ),
      )
      ..registerFactoryParam<RecipeSearchCubit, SearchRecipeListPayload, void>(
        (payload, _) => RecipeSearchCubit(
          payload: payload,
          searchRecipeListUseCase: getIt(),
        ),
      );
  }
}
