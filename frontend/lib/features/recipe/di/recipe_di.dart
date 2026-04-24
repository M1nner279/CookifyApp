import 'package:cookify/features/recipe/recipe_common/di/recipe_common_di.dart';
import 'package:cookify/features/recipe/recipe_common/data/repositories/saved_recipe_repository_impl.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/saved_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_detail/di/recipe_detail_di.dart';
import 'package:cookify/features/recipe/recipe_feed/di/recipe_feed_di.dart';
import 'package:cookify/features/recipe/recipe_form/di/recipe_form_di.dart';
import 'package:cookify/features/recipe/recipe_search/di/recipe_search_di.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    if (!getIt.isRegistered<SavedRecipeRepository>()) {
      getIt.registerSingleton<SavedRecipeRepository>(
        SavedRecipeRepositoryImpl(storage: getIt()),
      );
    }
    await getIt<SavedRecipeRepository>().init();

    await RecipeCommonDi.init();
    await RecipeFeedDi.init();
    await RecipeDetailDi.init();
    await RecipeSearchDi.init();
    await RecipeFormDi.init();
  }
}
