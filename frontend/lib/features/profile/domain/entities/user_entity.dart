import 'package:cookify/features/profile/domain/entities/user_statistic_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String? avatarUrl,
    required String login,
    required String email,
    required DateTime createdAt,
    required UserStatisticEntity statistic,
  }) = _UserEntity;
}
