import 'package:cookify/features/credentials_validation/domain/enums/confirm_password_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_confirm_password_payload.dart';

final class ValidateConfirmPasswordUseCase {
  ValidateConfirmPasswordUseCase();

  ConfirmPasswordValidationStatus call(ValidateConfirmPasswordPayload payload) {
    final password = payload.password;
    final confirmPassword = payload.confirmPassword;

    if (password != confirmPassword) {
      return ConfirmPasswordValidationStatus.notMatch;
    } else {
      return ConfirmPasswordValidationStatus.valid;
    }
  }
}
