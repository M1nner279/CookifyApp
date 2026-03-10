import 'package:cookify/feature/home/data/repository/home_repository_impl.dart';
import 'package:cookify/feature/home/domain/repository/home_repository.dart';
import 'package:cookify/feature/home/domain/usecase/get_recipe_list.dart';
import 'package:cookify/feature/home/presentation/bloc/home_cubit.dart';
import 'package:cookify/feature/recipe/data/repository/recipe_repository_impl.dart';
import 'package:cookify/feature/recipe/domain/repository/recipe_repository.dart';
import 'package:cookify/feature/recipe/domain/usecase/get_recipe.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_cubit.dart';
import 'package:get_it/get_it.dart';

class DI {
  static GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    // Utils

    // Home
    // Data sources

    // Repositories
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());

    // Use cases
    getIt.registerLazySingleton(() => GetRecipeList(repository: getIt()));

    // BLoCs
    getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(getRecipeList: getIt()),
    );

    // Recipe
    // Data sources

    // Repositories
    getIt.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl());

    // Use cases
    getIt.registerLazySingleton(() => GetRecipe(repository: getIt()));

    // BLoCs
    getIt.registerFactoryParam<RecipeCubit, String, void>(
      (id, _) => RecipeCubit(id: id, getRecipe: getIt()),
    );
  }
}
