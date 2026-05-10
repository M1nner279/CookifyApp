import 'dart:convert';

import 'package:cookify/features/profile/domain/entities/user_statistic_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class UserStatisticLocalStore {
  UserStatisticLocalStore({required FlutterSecureStorage storage})
    : _storage = storage;

  final FlutterSecureStorage _storage;

  static const _key = 'user_statistic_delta_v1';

  Future<UserStatisticEntity> getDelta() async {
    final raw = await _storage.read(key: _key);
    if (raw == null || raw.trim().isEmpty) {
      return _zero;
    }

    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      return _zero;
    }

    return UserStatisticEntity(
      favoriteRecipesCount:
          (decoded['favoriteRecipesCount'] as num?)?.toInt() ?? 0,
      createdRecipesCount:
          (decoded['createdRecipesCount'] as num?)?.toInt() ?? 0,
      publishedRecipesCount:
          (decoded['publishedRecipesCount'] as num?)?.toInt() ?? 0,
    );
  }

  Future<void> incrementFavoriteRecipesCount() async {
    await _increment(
      (current) => current.copyWith(
        favoriteRecipesCount: current.favoriteRecipesCount + 1,
      ),
    );
  }

  Future<void> decrementFavoriteRecipesCount() async {
    await _increment(
      (current) => current.copyWith(
        favoriteRecipesCount: current.favoriteRecipesCount - 1,
      ),
    );
  }

  Future<void> incrementCreatedRecipesCount() async {
    await _increment(
      (current) => current.copyWith(
        createdRecipesCount: current.createdRecipesCount + 1,
      ),
    );
  }

  Future<void> incrementPublishedRecipesCount() async {
    await _increment(
      (current) => current.copyWith(
        publishedRecipesCount: current.publishedRecipesCount + 1,
      ),
    );
  }

  Future<void> _increment(
    UserStatisticEntity Function(UserStatisticEntity current) update,
  ) async {
    final next = update(await getDelta());
    await _storage.write(
      key: _key,
      value: jsonEncode({
        'favoriteRecipesCount': next.favoriteRecipesCount,
        'createdRecipesCount': next.createdRecipesCount,
        'publishedRecipesCount': next.publishedRecipesCount,
      }),
    );
  }

  static const _zero = UserStatisticEntity(
    favoriteRecipesCount: 0,
    createdRecipesCount: 0,
    publishedRecipesCount: 0,
  );
}
