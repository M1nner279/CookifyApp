import 'package:freezed_annotation/freezed_annotation.dart';

part 'resend_sign_up_payload.freezed.dart';

@freezed
abstract class ResendSignUpPayload with _$ResendSignUpPayload {
  const factory ResendSignUpPayload({
    required String email,
  }) = _ResendSignUpPayload;
}
