import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/confirm_password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/email_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_confirm_password_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_email_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_login_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_password_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_email_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/features/auth/sign_up/domain/exceptions/sign_up_exception.dart';
import 'package:cookify/features/auth/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:cookify/features/auth/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required ValidateLoginUseCase validateLoginUseCase,
    required ValidateEmailUseCase validateEmailUseCase,
    required ValidatePasswordUseCase validatePasswordUseCase,
    required ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase,
    required SignUpUseCase signUpUseCase,
  }) : _validateLoginUseCase = validateLoginUseCase,
       _validateEmailUseCase = validateEmailUseCase,
       _validatePasswordUseCase = validatePasswordUseCase,
       _validateConfirmPasswordUseCase = validateConfirmPasswordUseCase,
       _signUpUseCase = signUpUseCase,
       super(SignUpInitial());

  final ValidateLoginUseCase _validateLoginUseCase;
  final ValidateEmailUseCase _validateEmailUseCase;
  final ValidatePasswordUseCase _validatePasswordUseCase;
  final ValidateConfirmPasswordUseCase _validateConfirmPasswordUseCase;
  final SignUpUseCase _signUpUseCase;

  Future<void> validateLogin(String login) async {
    if (state is SignUpError) {
      emit(
        (state as SignUpError).copyWith(
          loginException: null,
          signUpException: null,
        ),
      );
    }
    await _validateField<LoginException>(
      result: _validateLoginUseCase(ValidateLoginPayload(login: login)),
      getException: (result) => result.exception as LoginException?,
      updateError: (state, exception) =>
          state.copyWith(loginException: exception),
    );
  }

  Future<void> validateEmail(String email) async {
    if (state is SignUpError) {
      emit(
        (state as SignUpError).copyWith(
          emailException: null,
          signUpException: null,
        ),
      );
    }
    await _validateField<EmailException>(
      result: _validateEmailUseCase(ValidateEmailPayload(email: email)),
      getException: (result) => result.exception as EmailException?,
      updateError: (state, exception) =>
          state.copyWith(emailException: exception),
    );
  }

  Future<void> validatePassword(String password) async {
    if (state is SignUpError) {
      emit((state as SignUpError).copyWith(passwordException: null));
    }
    await _validateField<PasswordException>(
      result: _validatePasswordUseCase(
        ValidatePasswordPayload(password: password),
      ),
      getException: (result) => result.exception as PasswordException?,
      updateError: (state, exception) =>
          state.copyWith(passwordException: exception),
    );
  }

  Future<void> validateConfirmPassword(
    String password,
    String confirmPassword,
  ) async {
    if (state is SignUpError) {
      emit((state as SignUpError).copyWith(confirmPasswordException: null));
    }
    await _validateField<ConfirmPasswordException>(
      result: _validateConfirmPasswordUseCase(
        ValidateConfirmPasswordPayload(
          password: password,
          confirmPassword: confirmPassword,
        ),
      ),
      getException: (result) => result.exception as ConfirmPasswordException?,
      updateError: (state, exception) =>
          state.copyWith(confirmPasswordException: exception),
    );
  }

  Future<void> _validateField<T>({
    required Result result,
    required T? Function(Failure result) getException,
    required SignUpError Function(SignUpError state, T? exception) updateError,
  }) async {
    if (result is Failure) {
      final exception = getException(result);

      if (state is SignUpError) {
        emit(updateError(state as SignUpError, exception));
      } else {
        emit(updateError(SignUpError(), exception));
      }
    }
  }

  Future<void> signUp(
    String login,
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(SignUpLoading());

    await validateLogin(login);
    await validateEmail(email);
    await validatePassword(password);
    await validateConfirmPassword(password, confirmPassword);

    if (state is SignUpError) return;

    final result = await _signUpUseCase(
      SignUpPayload(login: login, email: email, password: password),
    );

    if (result is Success) {
      emit(SignUpSuccess());
    } else if (result is Failure) {
      final exception = result.exception;

      emit(SignUpError(signUpException: exception as SignUpException?));
    }
  }
}
