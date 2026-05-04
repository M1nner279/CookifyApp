import 'dart:convert';
import 'dart:math';

import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/ingredient_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_form/domain/entities/draft_recipe_entity.dart';
import 'package:cookify/features/recipe/recipe_form/domain/repositories/draft_recipe_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DraftRecipeRepositoryImpl implements DraftRecipeRepository {
  DraftRecipeRepositoryImpl({required FlutterSecureStorage storage})
    : _storage = storage;

  final FlutterSecureStorage _storage;

  static const _draftsKey = 'draft_recipes_v1';

  final ValueNotifier<List<DraftRecipeEntity>> _draftsNotifier =
      ValueNotifier<List<DraftRecipeEntity>>(<DraftRecipeEntity>[]);

  @override
  ValueListenable<List<DraftRecipeEntity>> get draftsListenable =>
      _draftsNotifier;

  @override
  List<DraftRecipeEntity> get drafts =>
      List<DraftRecipeEntity>.unmodifiable(_draftsNotifier.value);

  @override
  DraftRecipeEntity? getById(String id) {
    for (final draft in _draftsNotifier.value) {
      if (draft.id == id) return draft;
    }
    return null;
  }

  @override
  Future<void> init() async {
    final raw = await _storage.read(key: _draftsKey);
    if (raw == null || raw.trim().isEmpty) return;

    final decoded = jsonDecode(raw);
    if (decoded is! List) return;

    final drafts = decoded
        .whereType<Map<String, dynamic>>()
        .map(_fromJson)
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    _draftsNotifier.value = drafts;
  }

  @override
  Future<DraftRecipeEntity> upsert(DraftRecipeEntity draft) async {
    final resolved = draft.id.trim().isEmpty
        ? draft.copyWith(id: _generateId())
        : draft;

    final drafts = _draftsNotifier.value.toList();
    final index = drafts.indexWhere((d) => d.id == resolved.id);
    if (index == -1) {
      drafts.add(resolved);
    } else {
      drafts[index] = resolved;
    }

    drafts.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    _draftsNotifier.value = drafts;
    await _persist();
    return resolved;
  }

  @override
  Future<void> remove(String id) async {
    final drafts = _draftsNotifier.value.where((d) => d.id != id).toList();
    _draftsNotifier.value = drafts;
    await _persist();
  }

  Future<void> _persist() async {
    final payload = _draftsNotifier.value.map(_toJson).toList();
    await _storage.write(key: _draftsKey, value: jsonEncode(payload));
  }

  String _generateId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    final rnd = Random().nextInt(1 << 30);
    return '$now$rnd';
  }

  Map<String, dynamic> _toJson(DraftRecipeEntity draft) => {
    'id': draft.id,
    'updatedAt': draft.updatedAt.toIso8601String(),
    'name': draft.name,
    'description': draft.description,
    'cpfc': {
      'calories': draft.cpfc.calories,
      'proteins': draft.cpfc.proteins,
      'fats': draft.cpfc.fats,
      'carbohydrates': draft.cpfc.carbohydrates,
    },
    'difficulty': draft.difficulty.index,
    'cookingTimeMinutes': draft.cookingTimeMinutes,
    'categories': draft.categories
        .map((c) => {'id': c.id, 'name': c.name})
        .toList(),
    'ingredients': draft.ingredients
        .map(
          (i) => {
            'ingredient': {
              'id': i.ingredient.id,
              'name': i.ingredient.name,
              'cpfc': {
                'calories': i.ingredient.cpfc.calories,
                'proteins': i.ingredient.cpfc.proteins,
                'fats': i.ingredient.cpfc.fats,
                'carbohydrates': i.ingredient.cpfc.carbohydrates,
              },
            },
            'amount': i.amount,
            'unit': i.unit,
          },
        )
        .toList(),
    'steps': draft.steps
        .map(
          (s) => {
            'title': s.title,
            'description': s.description,
            if (s.photoPath != null) 'photoPath': s.photoPath,
          },
        )
        .toList(),
    'photoPaths': draft.photoPaths,
  };

  DraftRecipeEntity _fromJson(Map<String, dynamic> json) {
    final updatedAtRaw = json['updatedAt']?.toString();
    final updatedAt =
        updatedAtRaw == null ? DateTime.now() : DateTime.tryParse(updatedAtRaw);

    final cpfcJson = (json['cpfc'] as Map?)?.cast<String, dynamic>();
    final cpfc = CpfcEntity(
      calories: (cpfcJson?['calories'] as num?)?.toInt() ?? 0,
      proteins: (cpfcJson?['proteins'] as num?)?.toInt() ?? 0,
      fats: (cpfcJson?['fats'] as num?)?.toInt() ?? 0,
      carbohydrates: (cpfcJson?['carbohydrates'] as num?)?.toInt() ?? 0,
    );

    final difficultyIndex = (json['difficulty'] as num?)?.toInt() ?? 0;
    final safeDifficultyIndex = difficultyIndex.clamp(
      0,
      RecipeDifficulty.values.length - 1,
    );

    final categories = (json['categories'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((item) {
          final map = item.cast<String, dynamic>();
          return CategoryEntity(
            id: map['id']?.toString() ?? '',
            name: map['name']?.toString() ?? '',
          );
        })
        .toList();

    final ingredients = (json['ingredients'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((item) {
          final map = item.cast<String, dynamic>();
          final ingredientJson =
              (map['ingredient'] as Map?)?.cast<String, dynamic>();
          final ingredientCpfcJson =
              (ingredientJson?['cpfc'] as Map?)?.cast<String, dynamic>();
          final ingredient = IngredientEntity(
            id: ingredientJson?['id']?.toString() ?? '',
            name: ingredientJson?['name']?.toString() ?? '',
            cpfc: CpfcEntity(
              calories: (ingredientCpfcJson?['calories'] as num?)?.toInt() ?? 0,
              proteins:
                  (ingredientCpfcJson?['proteins'] as num?)?.toInt() ?? 0,
              fats: (ingredientCpfcJson?['fats'] as num?)?.toInt() ?? 0,
              carbohydrates:
                  (ingredientCpfcJson?['carbohydrates'] as num?)?.toInt() ?? 0,
            ),
          );

          return DraftRecipeIngredientEntity(
            ingredient: ingredient,
            amount: (map['amount'] as num?)?.toDouble() ?? 0,
            unit: map['unit']?.toString() ?? 'g',
          );
        })
        .toList();

    final steps = (json['steps'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((item) {
          final map = item.cast<String, dynamic>();
          return DraftRecipeStepEntity(
            title: map['title']?.toString() ?? '',
            description: map['description']?.toString() ?? '',
            photoPath: map['photoPath']?.toString(),
          );
        })
        .toList();

    final photoPaths = (json['photoPaths'] as List<dynamic>? ?? const [])
        .map((p) => p.toString())
        .toList();

    return DraftRecipeEntity(
      id: json['id']?.toString() ?? '',
      updatedAt: updatedAt ?? DateTime.now(),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      cpfc: cpfc,
      difficulty: RecipeDifficulty.values[safeDifficultyIndex],
      cookingTimeMinutes: (json['cookingTimeMinutes'] as num?)?.toInt() ?? 45,
      categories: categories,
      ingredients: ingredients,
      steps: steps,
      photoPaths: photoPaths,
    );
  }
}

