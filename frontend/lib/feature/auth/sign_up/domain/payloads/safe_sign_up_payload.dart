import 'package:freezed_annotation/freezed_annotation.dart';

part 'safe_sign_up_payload.freezed.dart';

@freezed
abstract class SafeSignUpPayload with _$SafeSignUpPayload {
  const factory SafeSignUpPayload({
    required String login,
    required String email,
    required String passwordHash,
  }) = _SafeSignUpPayload;
}
