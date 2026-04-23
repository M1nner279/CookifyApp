import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_category_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_common/domain/use_cases/search_ingredient_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_form/data/data_sources/recipe_form_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_form/data/data_sources/recipe_form_remote_data_source_impl.dart';
import 'package:cookify/features/recipe/recipe_form/data/repositories/recipe_form_repository_impl.dart';
import 'package:cookify/features/recipe/recipe_form/domain/repositories/recipe_form_repository.dart';
import 'package:cookify/features/recipe/recipe_form/domain/use_cases/publish_recipe_use_case.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/bloc/recipe_form_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeFormDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<RecipeFormRemoteDataSource>(
        () => RecipeFormRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<RecipeFormRepository>(
        () => RecipeFormRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => PublishRecipeUseCase(getIt()))
      ..registerFactory(
        () => RecipeFormCubit(
          publishRecipeUseCase: getIt(),
          searchCategoryListUseCase: getIt<SearchCategoryListUseCase>(),
          searchIngredientListUseCase: getIt<SearchIngredientListUseCase>(),
        ),
      );
  }
}
