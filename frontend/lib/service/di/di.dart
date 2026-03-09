import 'package:cookify/feature/recipe/data/repository/recipe_repository_impl.dart';
import 'package:cookify/feature/recipe/domain/repository/recipe_repository.dart';
import 'package:cookify/feature/recipe/domain/usecase/get_recipe.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_cubit.dart';
import 'package:get_it/get_it.dart';

class DI {
  static GetIt getIt = GetIt.instance;

  static Future<void> init() async {
    // Utils

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
