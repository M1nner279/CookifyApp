import 'package:cookify/features/credentials_validation/domain/consts/credentials_validation_bounds.dart';
import 'package:cookify/features/credentials_validation/domain/enums/login_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_login_payload.dart';

final class ValidateLoginUseCase {
  ValidateLoginUseCase();

  LoginValidationStatus call(ValidateLoginPayload payload) {
    final login = payload.login;

    if (login.isEmpty) {
      return LoginValidationStatus.empty;
    } else if (login.length < loginMinLength) {
      return LoginValidationStatus.tooShort;
    } else if (login.length > loginMaxLength) {
      return LoginValidationStatus.tooLong;
    } else {
      return LoginValidationStatus.valid;
    }
  }
}
