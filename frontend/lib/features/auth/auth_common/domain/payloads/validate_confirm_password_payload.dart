import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_confirm_password_payload.freezed.dart';

@freezed
abstract class ValidateConfirmPasswordPayload
    with _$ValidateConfirmPasswordPayload {
  const factory ValidateConfirmPasswordPayload({
    required String password,
    required String confirmPassword,
  }) = _ValidateConfirmPasswordPayload;
}
