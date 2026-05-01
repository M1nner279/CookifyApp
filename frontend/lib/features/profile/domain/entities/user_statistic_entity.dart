import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_statistic_entity.freezed.dart';

@freezed
abstract class UserStatisticEntity with _$UserStatisticEntity {
  const factory UserStatisticEntity({
    required int favoriteRecipesCount,
    required int createdRecipesCount,
    required int publishedRecipesCount,
  }) = _UserStatisticEntity;
}
