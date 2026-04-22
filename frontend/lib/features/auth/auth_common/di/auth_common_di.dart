import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_email_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_password_use_case.dart';
import 'package:get_it/get_it.dart';

abstract class AuthCommonDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory(() => ValidateLoginUseCase())
      ..registerFactory(() => ValidateEmailUseCase())
      ..registerFactory(() => ValidatePasswordUseCase())
      ..registerFactory(() => ValidateConfirmPasswordUseCase());
  }
}
