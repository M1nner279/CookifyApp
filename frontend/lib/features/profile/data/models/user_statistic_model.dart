import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_statistic_model.freezed.dart';
part 'user_statistic_model.g.dart';

@freezed
abstract class UserStatisticModel with _$UserStatisticModel {
  const factory UserStatisticModel({
    @JsonKey(name: 'favorite_recipes_count') required int favoriteRecipesCount,
    @JsonKey(name: 'created_recipes_count') required int createdRecipesCount,
    @JsonKey(name: 'published_recipes_count')
    required int publishedRecipesCount,
  }) = _UserStatisticModel;

  factory UserStatisticModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatisticModelFromJson(json);
}
