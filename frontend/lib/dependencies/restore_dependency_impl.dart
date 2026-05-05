import 'package:cookify/core/presentation/localize/localize.dart';
import 'package:cookify/features/credentials_validation/domain/enums/email_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/enums/login_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_email_payload.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_login_payload.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_email_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_email_validation_status.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_login_validation_status.dart';
import 'package:cookify/features/restore/dependencies/restore_dependency.dart';

final class RestoreDependencyImpl implements RestoreDependency {
  RestoreDependencyImpl({
    required ValidateLoginUseCase validateLoginUseCase,
    required ValidateEmailUseCase validateEmailUseCase,
  }) : _validateLoginUseCase = validateLoginUseCase,
       _validateEmailUseCase = validateEmailUseCase;

  final ValidateLoginUseCase _validateLoginUseCase;
  final ValidateEmailUseCase _validateEmailUseCase;

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
}
