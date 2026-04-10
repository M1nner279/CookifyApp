import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_sign_up_payload.freezed.dart';

@freezed
abstract class VerifySignUpPayload with _$VerifySignUpPayload {
  const factory VerifySignUpPayload({
    required String email,
    required String code,
  }) = _VerifySignUpPayload;
}
