import 'dart:convert';

import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_dto.dart';
import 'package:hive/hive.dart';

abstract interface class RecipeLocalDataSource {
  Future<void> saveRecipe(RecipeDto recipe);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  @override
  Future<void> saveRecipe(RecipeDto recipe) async {
    final recipeBox = Hive.box<String>('recipes');

    final recipeJson = recipe.toJson();
    recipeJson['serverId'] = recipe.id;
    recipeJson['isPublished'] = true;
    recipeJson['id'] = recipe.id;

    await recipeBox.add(jsonEncode(recipeJson));
  }
}
