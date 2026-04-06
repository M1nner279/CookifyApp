import 'package:cookify/feature/profile/di/profile_di.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/di/recipe_saved_list_di.dart';
import 'package:get_it/get_it.dart';

abstract class Di {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    await RecipeSavedListDi.init();
    await ProfileDi.init();
  }
}