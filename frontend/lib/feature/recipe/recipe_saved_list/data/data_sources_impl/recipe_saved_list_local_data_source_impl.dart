import 'dart:convert';

import 'package:cookify/feature/recipe/recipe_common/data/models/category_dto.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/data_sources/recipe_saved_list_local_data_source.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/data/models/saved_recipe_preview_dto.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RecipeSavedListLocalDataSourceImpl
    implements RecipeSavedListLocalDataSource {
  @override
  Future<List<SavedRecipePreviewDto>> getSavedRecipes() {
    return Future.value([
      SavedRecipePreviewDto(
        id: '0',
        serverId: null,
        isPublished: true,
        photoUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRSEUQRQg76XaB4tPERbflDAxYP2f4f27BGjYiEK0DqDK0_R3cqOe2VggvyZqvOvxm16vluE58iF6nED9OakbYZUiiY_YQ6N6n5-063sQk&s=10',
        difficulty: RecipeDifficulty.easy,
        name: 'Tuscan Butter Roasted Chicken',
        cookingTime: 45,
        categories: [
          CategoryDto(id: '0', name: 'Niggers'),
        ],
      ),

      SavedRecipePreviewDto(
        id: '1',
        serverId: null,
        isPublished: false,
        photoUrl:
            'https://yt3.ggpht.com/GRcLEx1A8wSj0jW4gkeVMahv15l6ybE9-IFA-61hap5Waj2mrffBw5WChnZwvTKYlvEP0l97mQ=s88-c-k-c0x00ffffff-no-rj',
        difficulty: RecipeDifficulty.medium,
        name: 'Wild Basil & Pine Nut Pesto',
        cookingTime: 20,
        categories: [
          CategoryDto(id: '0', name: 'Niggers'),
          CategoryDto(id: '1', name: 'Ginners'),
        ],
      ),

      SavedRecipePreviewDto(
        id: '0',
        serverId: null,
        isPublished: false,
        photoUrl:
            'https://yt3.ggpht.com/GRcLEx1A8wSj0jW4gkeVMahv15l6ybE9-IFA-61hap5Waj2mrffBw5WChnZwvTKYlvEP0l97mQ=s88-c-k-c0x00ffffff-no-rj',
        difficulty: RecipeDifficulty.easy,
        name: 'Tuscan Butter Roasted Chicken',
        cookingTime: 45,
        categories: [
          CategoryDto(id: '1', name: 'Ginners'),
        ],
      ),

      SavedRecipePreviewDto(
        id: '1',
        serverId: null,
        isPublished: false,
        photoUrl:
            'https://yt3.ggpht.com/GRcLEx1A8wSj0jW4gkeVMahv15l6ybE9-IFA-61hap5Waj2mrffBw5WChnZwvTKYlvEP0l97mQ=s88-c-k-c0x00ffffff-no-rj',
        difficulty: RecipeDifficulty.medium,
        name: 'Wild Basil & Pine Nut Pesto',
        cookingTime: 20,
        categories: [],
      ),

      SavedRecipePreviewDto(
        id: '0',
        serverId: null,
        isPublished: false,
        photoUrl:
            'https://yt3.ggpht.com/GRcLEx1A8wSj0jW4gkeVMahv15l6ybE9-IFA-61hap5Waj2mrffBw5WChnZwvTKYlvEP0l97mQ=s88-c-k-c0x00ffffff-no-rj',
        difficulty: RecipeDifficulty.easy,
        name: 'Tuscan Butter Roasted Chicken',
        cookingTime: 45,
        categories: [],
      ),

      SavedRecipePreviewDto(
        id: '1',
        serverId: null,
        isPublished: false,
        photoUrl:
            'https://yt3.ggpht.com/GRcLEx1A8wSj0jW4gkeVMahv15l6ybE9-IFA-61hap5Waj2mrffBw5WChnZwvTKYlvEP0l97mQ=s88-c-k-c0x00ffffff-no-rj',
        difficulty: RecipeDifficulty.medium,
        name: 'Wild Basil & Pine Nut Pesto',
        cookingTime: 20,
        categories: [],
      ),

      SavedRecipePreviewDto(
        id: '0',
        serverId: null,
        isPublished: false,
        photoUrl:
            'https://yt3.ggpht.com/GRcLEx1A8wSj0jW4gkeVMahv15l6ybE9-IFA-61hap5Waj2mrffBw5WChnZwvTKYlvEP0l97mQ=s88-c-k-c0x00ffffff-no-rj',
        difficulty: RecipeDifficulty.easy,
        name: 'Tuscan Butter Roasted Chicken',
        cookingTime: 45,
        categories: [],
      ),
    ]);

    final recipeBox = Hive.box<String>('recipes');

    final recipes = recipeBox.values
        .map((e) => SavedRecipePreviewDto.fromJson(jsonDecode(e)))
        .toList();

    return Future.value(recipes);
  }
}
