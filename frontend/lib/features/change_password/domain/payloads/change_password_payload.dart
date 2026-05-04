import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_payload.freezed.dart';

@freezed
abstract class ChangePasswordPayload with _$ChangePasswordPayload {
  const factory ChangePasswordPayload({required String password}) =
      _ChangePasswordPayload;
}
