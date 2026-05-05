import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_payload.freezed.dart';

@freezed
abstract class SignInPayload with _$SignInPayload {
  const factory SignInPayload({
    required String login,
    required String password,
  }) = _SignInPayload;
}
