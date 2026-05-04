import 'package:cookify/features/credentials_validation/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_email_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_password_use_case.dart';

abstract class CredentialsValidationDi {
  static ValidateLoginUseCase get validateLoginUseCase =>
      ValidateLoginUseCase();

  static ValidateEmailUseCase get validateEmailUseCase =>
      ValidateEmailUseCase();

  static ValidatePasswordUseCase get validatePasswordUseCase =>
      ValidatePasswordUseCase();

  static ValidateConfirmPasswordUseCase get validateConfirmPasswordUseCase =>
      ValidateConfirmPasswordUseCase();
}
