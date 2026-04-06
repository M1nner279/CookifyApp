import 'package:cookify/feature/recipe/recipe_feed/datasource/home_remote_data_source.dart';
import 'package:cookify/feature/home/data/repository/home_repository_impl.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/repository/home_repository.dart';
import 'package:cookify/feature/recipe/recipe_feed/domain/usecase/get_recipe_list.dart';
import 'package:cookify/feature/recipe/recipe_feed/presentation/bloc/home_cubit.dart';
import 'package:cookify/feature/recipe/recipe_detail/data/datasource/recipe_remote_data_source.dart';
import 'package:cookify/feature/recipe/recipe_detail/data/repository/recipe_repository_impl.dart';
import 'package:cookify/feature/recipe/recipe_detail/domain/repository/recipe_repository.dart';
import 'package:cookify/feature/recipe/recipe_detail/domain/usecase/get_recipe.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/bloc/recipe_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DI {
  static GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    // Utils
    getIt.registerLazySingleton(() => Dio());

    // Home
    // Data sources
    getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(getIt()));

    // Repositories
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(remoteDataSource: getIt()));

    // Use cases
    getIt.registerLazySingleton(() => GetRecipeList(repository: getIt()));

    // BLoCs
    getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(getRecipeList: getIt()),
    );

    // Recipe
    // Data sources
    getIt.registerLazySingleton<RecipeRemoteDataSource>(() => RecipeRemoteDataSourceImpl(getIt()));

    // Repositories
    getIt.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl(remoteDataSource: getIt()));

    // Use cases
    getIt.registerLazySingleton(() => GetRecipe(repository: getIt()));

    // BLoCs
    getIt.registerFactoryParam<RecipeCubit, String, void>(
      (id, _) => RecipeCubit(id: id, getRecipe: getIt()),
    );
  }
}
