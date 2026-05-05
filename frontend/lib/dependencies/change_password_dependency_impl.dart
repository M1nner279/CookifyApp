import 'package:cookify/core/presentation/localize/localize.dart';
import 'package:cookify/features/change_password/dependencies/change_password_dependency.dart';
import 'package:cookify/features/credentials_validation/domain/enums/confirm_password_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/enums/password_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_confirm_password_payload.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_password_payload.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_confirm_password_validation_status.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_password_validation_status.dart';

final class ChangePasswordDependencyImpl implements ChangePasswordDependency {
  ChangePasswordDependencyImpl({
    required ValidatePasswordUseCase validatePasswordUseCase,
    required ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase,
  }) : _validatePasswordUseCase = validatePasswordUseCase,
       _validateConfirmPasswordUseCase = validateConfirmPasswordUseCase;

  final ValidatePasswordUseCase _validatePasswordUseCase;
  final ValidateConfirmPasswordUseCase _validateConfirmPasswordUseCase;

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
