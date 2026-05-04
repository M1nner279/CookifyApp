import 'package:cookify/features/credentials_validation/domain/consts/credentials_validation_bounds.dart';
import 'package:cookify/features/credentials_validation/domain/enums/email_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_email_payload.dart';

final class ValidateEmailUseCase {
  ValidateEmailUseCase();

  EmailValidationStatus call(ValidateEmailPayload payload) {
    final email = payload.email;

    if (email.isEmpty) {
      return EmailValidationStatus.empty;
    } else if (!RegExp(emailValidationRegex).hasMatch(email)) {
      return EmailValidationStatus.invalid;
    } else {
      return EmailValidationStatus.valid;
    }
  }
}
