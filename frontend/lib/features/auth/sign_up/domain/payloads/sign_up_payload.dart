import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_payload.freezed.dart';

@freezed
abstract class SignUpPayload with _$SignUpPayload {
  const factory SignUpPayload({
    required String login,
    required String email,
    required String password,
  }) = _SignUpPayload;
}
