import 'package:cookify/feature/profile/domain/entity/user_entity.dart';
import 'package:cookify/feature/profile/domain/entity/user_recipe_statistic_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_entity.freezed.dart';

@freezed
abstract class UserInfoEntity with _$UserInfoEntity {
  const factory UserInfoEntity({
    required UserEntity user,
    required UserRecipeStatisticEntity userRecipeStatistic,
  }) = _UserInfoEntity;
}
