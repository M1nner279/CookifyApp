import 'package:cookify/feature/recipe/recipe_saved_list/data/data_sources/recipe_saved_list_local_data_source.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/data_sources_impl/recipe_saved_list_local_data_source_impl.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/repositories_impl/recipe_saved_list_repository_impl.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/repositories/recipe_saved_list_repository.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/domain/use_cases/get_saved_recipes_use_case.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/bloc/recipe_saved_list_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeSavedListDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerSingleton<RecipeSavedListLocalDataSource>(
        RecipeSavedListLocalDataSourceImpl(),
      )
      ..registerSingleton<RecipeSavedListRepository>(
        RecipeSavedListRepositoryImpl(localDataSource: getIt()),
      )
      ..registerSingleton(GetSavedRecipesUseCase(repository: getIt()))
      ..registerFactory(
        () => RecipeSavedListCubit(getSavedRecipesUseCase: getIt()),
      );
  }
}
