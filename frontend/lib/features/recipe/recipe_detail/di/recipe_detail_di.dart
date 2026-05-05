import 'package:cookify/features/recipe/recipe_detail/data/data_sources/recipe_detail_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_detail/data/data_sources/recipe_detail_remote_data_source_impl.dart';
import 'package:cookify/features/recipe/recipe_detail/data/repositories/recipe_detail_repository_impl.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/repositories/recipe_detail_repository.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/use_cases/get_recipe_detail_use_case.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/bloc/recipe_detail_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeDetailDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<RecipeDetailRemoteDataSource>(
        () => RecipeDetailRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<RecipeDetailRepository>(
        () => RecipeDetailRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => GetRecipeDetailUseCase(getIt()))
      ..registerFactoryParam<RecipeDetailCubit, String, void>(
        (id, _) => RecipeDetailCubit(
          id: id,
          getRecipeDetailUseCase: getIt(),
          userSavedRecipeDetailRepository: getIt(),
        ),
      );
  }
}
