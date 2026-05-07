import 'package:cookify/features/profile/data/models/user_statistic_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    @JsonKey(name: 'avatar_url') required String? avatarUrl,
    required String login,
    required String email,
    @JsonKey(name: 'created_at') required String createdAt,
    required UserStatisticModel statistic,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
