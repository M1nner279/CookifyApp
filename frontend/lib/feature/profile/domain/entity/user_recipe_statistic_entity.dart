import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_recipe_statistic_entity.freezed.dart';

@freezed
abstract class UserRecipeStatisticEntity with _$UserRecipeStatisticEntity {
  const factory UserRecipeStatisticEntity({
    required int favoriteRecipeCount,
    required int createdRecipeCount,
    required int publishedRecipeCount,
  }) = _UserRecipeStatisticEntity;
}
