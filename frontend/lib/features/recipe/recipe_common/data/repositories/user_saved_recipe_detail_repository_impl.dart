import 'dart:convert';

import 'package:cookify/features/recipe/recipe_common/data/user_saved_recipe_detail_codec.dart';
import 'package:cookify/features/recipe/recipe_common/domain/repositories/user_saved_recipe_detail_repository.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSavedRecipeDetailRepositoryImpl
    implements UserSavedRecipeDetailRepository {
  UserSavedRecipeDetailRepositoryImpl({required FlutterSecureStorage storage})
    : _storage = storage;

  final FlutterSecureStorage _storage;

  static const _key = 'user_saved_recipe_details_v1';

  final Map<String, RecipeDetailEntity> _byId = {};

  @override
  Future<void> init() async {
    _byId.clear();
    final raw = await _storage.read(key: _key);
    if (raw == null || raw.trim().isEmpty) return;

    final decoded = jsonDecode(raw);
    if (decoded is! Map) return;

    for (final entry in decoded.entries) {
      final id = entry.key.toString();
      final value = entry.value;
      if (value is! Map) continue;
      try {
        _byId[id] = UserSavedRecipeDetailCodec.fromJson(
          value.cast<String, dynamic>(),
        );
      } on Object {
        continue;
      }
    }
  }

  @override
  RecipeDetailEntity? getById(String recipeId) => _byId[recipeId];

  @override
  Future<void> save(String recipeId, RecipeDetailEntity detail) async {
    _byId[recipeId] = detail;
    await _persist();
  }

  @override
  Future<void> remove(String recipeId) async {
    _byId.remove(recipeId);
    await _persist();
  }

  Future<void> _persist() async {
    final payload = <String, dynamic>{};
    for (final e in _byId.entries) {
      payload[e.key] = UserSavedRecipeDetailCodec.toJson(e.value);
    }
    await _storage.write(key: _key, value: jsonEncode(payload));
  }
}
