import 'package:freezed_annotation/freezed_annotation.dart';

part 'safe_sign_in_payload.freezed.dart';

@freezed
abstract class SafeSignInPayload with _$SafeSignInPayload {
  const factory SafeSignInPayload({
    required String login,
    required String passwordHash,
  }) = _SafeSignInPayload;
}
