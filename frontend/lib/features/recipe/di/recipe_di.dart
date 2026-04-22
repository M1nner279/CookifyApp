import 'package:cookify/features/recipe/recipe_common/di/recipe_common_di.dart';
import 'package:cookify/features/recipe/recipe_detail/di/recipe_detail_di.dart';
import 'package:cookify/features/recipe/recipe_feed/di/recipe_feed_di.dart';
import 'package:cookify/features/recipe/recipe_search/di/recipe_search_di.dart';
import 'package:get_it/get_it.dart';

abstract class RecipeDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    await RecipeCommonDi.init();
    await RecipeFeedDi.init();
    await RecipeDetailDi.init();
    await RecipeSearchDi.init();
  }
}
