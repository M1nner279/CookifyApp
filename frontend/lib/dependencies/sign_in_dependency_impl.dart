import 'package:cookify/core/presentation/localize/localize.dart';
import 'package:cookify/features/sign_in/dependecies/sign_in_dependency.dart';
import 'package:cookify/features/credentials_validation/domain/enums/login_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/enums/password_validation_status.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_login_payload.dart';
import 'package:cookify/features/credentials_validation/domain/payloads/validate_password_payload.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/credentials_validation/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_login_validation_status.dart';
import 'package:cookify/features/credentials_validation/presentation/extensions/localized_password_validation_status.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/payloads/set_token_payload.dart';
import 'package:cookify/features/token/domain/use_cases/set_token_use_case.dart';

final class SignInDependencyImpl implements SignInDependency {
  SignInDependencyImpl({
    required ValidateLoginUseCase validateLoginUseCase,
    required ValidatePasswordUseCase validatePasswordUseCase,
    required SetTokenUseCase setTokenUseCase,
  }) : _validateLoginUseCase = validateLoginUseCase,
       _validatePasswordUseCase = validatePasswordUseCase,
       _setTokenUseCase = setTokenUseCase;

  final ValidateLoginUseCase _validateLoginUseCase;
  final ValidatePasswordUseCase _validatePasswordUseCase;
  final SetTokenUseCase _setTokenUseCase;

  @override
  Localize? validateLogin(String login) {
    final status = _validateLoginUseCase(ValidateLoginPayload(login: login));

    return status == LoginValidationStatus.empty ? status.localize : null;
  }

  @override
  Localize? validatePassword(String password) {
    final status = _validatePasswordUseCase(
      ValidatePasswordPayload(password: password),
    );

    return status == PasswordValidationStatus.empty ? status.localize : null;
  }

  @override
  Future<void> setToken(Token token) async {
    await _setTokenUseCase(SetTokenPayload(token: token));
  }
}
