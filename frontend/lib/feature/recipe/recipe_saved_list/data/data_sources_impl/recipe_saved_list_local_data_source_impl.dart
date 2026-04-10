import 'dart:convert';

import 'package:cookify/feature/recipe/recipe_common/data/models/category_dto.dart';
import 'package:cookify/feature/recipe/recipe_common/data/models/recipe_dto.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/data_sources/recipe_saved_list_local_data_source.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/models/saved_recipe_preview_dto.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecipeSavedListLocalDataSourceImpl
    implements RecipeSavedListLocalDataSource {
  @override
  Future<List<RecipeDto>> getSavedRecipes() {
    final recipeBox = Hive.box<String>('recipes');

    final recipes = recipeBox.values
        .map((e) => RecipeDto.fromJson(jsonDecode(e)))
        .toList();

    return Future.value(recipes);
  }
}
