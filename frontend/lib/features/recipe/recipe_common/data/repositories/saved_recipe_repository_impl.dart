import 'dart:convert';

import 'package:cookify/features/recipe/recipe_common/domain/repositories/saved_recipe_repository.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/user_saved_recipe_detail_repository.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class SavedRecipeRepositoryImpl implements SavedRecipeRepository {
  SavedRecipeRepositoryImpl({required FlutterSecureStorage storage})
    : _storage = storage;

  final FlutterSecureStorage _storage;

  static const _savedRecipesKey = 'saved_recipes_v1';

  final ValueNotifier<List<RecipePreviewEntity>> _savedRecipesNotifier =
      ValueNotifier<List<RecipePreviewEntity>>(<RecipePreviewEntity>[]);

  @override
  ValueListenable<List<RecipePreviewEntity>> get savedRecipesListenable =>
      _savedRecipesNotifier;

  @override
  List<RecipePreviewEntity> get savedRecipes =>
      List<RecipePreviewEntity>.unmodifiable(_savedRecipesNotifier.value);

  @override
  Future<void> init() async {
    final raw = await _storage.read(key: _savedRecipesKey);
    if (raw == null || raw.trim().isEmpty) return;

    final decoded = jsonDecode(raw);
    if (decoded is! List) return;

    final recipes = decoded
        .whereType<Map<String, dynamic>>()
        .map(_fromJson)
        .toList();
    _savedRecipesNotifier.value = recipes;
  }

  @override
  bool isSaved(String recipeId) {
    return _savedRecipesNotifier.value.any((recipe) => recipe.id == recipeId);
  }

  @override
  Future<void> saveRecipe(RecipePreviewEntity recipe) async {
    final recipes = _savedRecipesNotifier.value.toList();
    final existingIndex = recipes.indexWhere((item) => item.id == recipe.id);
    if (existingIndex == -1) {
      recipes.add(recipe);
    } else {
      recipes[existingIndex] = recipe;
    }
    _savedRecipesNotifier.value = recipes;
    await _persist();
  }

  @override
  Future<void> removeRecipe(String recipeId) async {
    final recipes = _savedRecipesNotifier.value
        .where((recipe) => recipe.id != recipeId)
        .toList();
    _savedRecipesNotifier.value = recipes;
    await _persist();
    if (GetIt.I.isRegistered<UserSavedRecipeDetailRepository>()) {
      await GetIt.I<UserSavedRecipeDetailRepository>().remove(recipeId);
    }
  }

  @override
  Future<void> toggleRecipe(RecipePreviewEntity recipe) async {
    if (isSaved(recipe.id)) {
      await removeRecipe(recipe.id);
      return;
    }
    await saveRecipe(recipe);
  }

  Future<void> _persist() async {
    final payload = _savedRecipesNotifier.value.map(_toJson).toList();
    await _storage.write(key: _savedRecipesKey, value: jsonEncode(payload));
  }

  Map<String, dynamic> _toJson(RecipePreviewEntity recipe) => {
    'id': recipe.id,
    'photoUrl': recipe.photoUrl,
    'name': recipe.name,
    'cookingTime': recipe.cookingTime,
    'servingCount': recipe.servingCount,
    'difficulty': recipe.difficulty.index,
    'categories': recipe.categories,
  };

  RecipePreviewEntity _fromJson(Map<String, dynamic> json) {
    final difficultyIndex = (json['difficulty'] as num?)?.toInt() ?? 0;
    final safeIndex = difficultyIndex.clamp(
      0,
      RecipeDifficulty.values.length - 1,
    );

    return RecipePreviewEntity(
      id: json['id']?.toString() ?? '',
      photoUrl: json['photoUrl']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      cookingTime: (json['cookingTime'] as num?)?.toInt() ?? 0,
      servingCount: (json['servingCount'] as num?)?.toInt() ?? 0,
      difficulty: RecipeDifficulty.values[safeIndex],
      categories: (json['categories'] as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList(),
    );
  }
}
