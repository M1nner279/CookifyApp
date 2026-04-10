import 'package:cookify/feature/auth/sign_up/data/repositories_impl/sign_up_repository_impl.dart';
import 'package:cookify/feature/auth/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/resend_sign_up_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_email_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/verify_sign_up_use_case.dart';
import 'package:cookify/feature/auth/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class SignUpDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerSingleton<SignUpRepository>(SignUpRepositoryImpl())
      ..registerSingleton(ValidateLoginUseCase())
      ..registerSingleton(ValidateEmailUseCase())
      ..registerSingleton(ValidatePasswordUseCase())
      ..registerSingleton(ValidateConfirmPasswordUseCase())
      ..registerSingleton(SignUpUseCase(getIt()))
      ..registerSingleton(VerifySignUpUseCase(getIt()))
      ..registerSingleton(ResendSignUpUseCase(getIt()))
      ..registerSingleton(
        SignUpCubit(
          validateLoginUseCase: getIt(),
          validateEmailUseCase: getIt(),
          validatePasswordUseCase: getIt(),
          validateConfirmPasswordUseCase: getIt(),
          signUpUseCase: getIt(),
          verifySignUpUseCase: getIt(),
          resendSignUpUseCase: getIt(),
        ),
      );
  }
}
