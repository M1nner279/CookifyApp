import 'package:cookify/core/presentation/localize/localize.dart';
import 'package:cookify/features/credentials_validation/domain/enums/confirm_password_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/enums/email_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_confirm_password_payload.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_email_payload.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_email_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/enums/login_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/enums/password_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_login_payload.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_password_payload.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_confirm_password_validation_status.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_email_validation_status.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_login_validation_status.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_password_validation_status.dart';
import 'package:cookify/features/sign_up/dependencies/sign_up_dependency.dart';

final class SignUpDependencyImpl implements SignUpDependency {
  SignUpDependencyImpl({
    required ValidateLoginUseCase validateLoginUseCase,
    required ValidateEmailUseCase validateEmailUseCase,
    required ValidatePasswordUseCase validatePasswordUseCase,
    required ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase,
  }) : _validateLoginUseCase = validateLoginUseCase,
       _validateEmailUseCase = validateEmailUseCase,
       _validatePasswordUseCase = validatePasswordUseCase,
       _validateConfirmPasswordUseCase = validateConfirmPasswordUseCase;

  final ValidateLoginUseCase _validateLoginUseCase;
  final ValidateEmailUseCase _validateEmailUseCase;
  final ValidatePasswordUseCase _validatePasswordUseCase;
  final ValidateConfirmPasswordUseCase _validateConfirmPasswordUseCase;

  @override
  Localize? validateLogin(String login) {
    final status = _validateLoginUseCase(ValidateLoginPayload(login: login));

    return status == LoginValidationStatus.valid ? null : status.localize;
  }

  @override
  Localize? validateEmail(String email) {
    final status = _validateEmailUseCase(ValidateEmailPayload(email: email));

    return status == EmailValidationStatus.valid ? null : status.localize;
  }

  @override
  Localize? validatePassword(String password) {
    final status = _validatePasswordUseCase(
      ValidatePasswordPayload(password: password),
    );

    return status == PasswordValidationStatus.valid ? null : status.localize;
  }

  @override
  Localize? validateConfirmPassword(String password, String confirmPassword) {
    final status = _validateConfirmPasswordUseCase(
      ValidateConfirmPasswordPayload(
        password: password,
        confirmPassword: confirmPassword,
      ),
    );

    return status == ConfirmPasswordValidationStatus.valid
        ? null
        : status.localize;
  }
}
