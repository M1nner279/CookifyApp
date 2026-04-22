import 'package:cookify/features/recipe/recipe_feed/data/data_sources/recipe_feed_remote_data_source.dart';
import 'package:cookify/features/recipe/recipe_feed/data/data_sources/recipe_feed_remote_data_source_impl.dart';
import 'package:cookify/features/recipe/recipe_feed/data/repositories/recipe_feed_repository_impl.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/repositories/recipe_feed_repository.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/use_cases/get_recipe_list_use_case.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/bloc/recipe_feed_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeFeedDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<RecipeFeedRemoteDataSource>(
        () => RecipeFeedRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<RecipeFeedRepository>(
        () => RecipeFeedRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => GetRecipeListUseCase(getIt()))
      ..registerFactory(() => RecipeFeedCubit(getRecipeListUseCase: getIt()));
  }
}
