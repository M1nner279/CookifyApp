import 'package:cookify/features/credentials_validation/domain/consts/credentials_validation_bounds.dart';
import 'package:cookify/features/credentials_validation/domain/enums/password_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_password_payload.dart';

final class ValidatePasswordUseCase {
  ValidatePasswordUseCase();

  PasswordValidationStatus call(ValidatePasswordPayload payload) {
    final password = payload.password;

    if (password.isEmpty) {
      return PasswordValidationStatus.empty;
    } else if (password.length < passwordMinLength) {
      return PasswordValidationStatus.tooShort;
    } else if (password.length > passwordMaxLength) {
      return PasswordValidationStatus.tooLong;
    } else if (!RegExp(passwordValidationRegex).hasMatch(password)) {
      return PasswordValidationStatus.invalid;
    } else {
      return PasswordValidationStatus.valid;
    }
  }
}
