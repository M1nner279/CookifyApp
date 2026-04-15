import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_login_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_password_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/features/auth/sign_in/domain/exceptions/sign_in_exception.dart';
import 'package:cookify/features/auth/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/auth/sign_in/domain/use_cases/sign_up_use_case.dart';
import 'package:cookify/features/auth/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required ValidateLoginUseCase validateLoginUseCase,
    required ValidatePasswordUseCase validatePasswordUseCase,
    required SignInUseCase signInUseCase,
  }) : _validateLoginUseCase = validateLoginUseCase,
       _validatePasswordUseCase = validatePasswordUseCase,
       _signInUseCase = signInUseCase,
       super(SignInInitial());

  final ValidateLoginUseCase _validateLoginUseCase;
  final ValidatePasswordUseCase _validatePasswordUseCase;
  final SignInUseCase _signInUseCase;

  Future<void> validateLogin(String login) async {
    if (state is SignInError) {
      emit(
        (state as SignInError).copyWith(
          loginException: null,
          signInException: null,
        ),
      );
    }
    await _validateField<LoginException>(
      result: _validateLoginUseCase(ValidateLoginPayload(login: login)),
      getException: (result) => result.exception as LoginException?,
      updateError: (state, exception) =>
          state.copyWith(loginException: exception),
      validatedExceptions: [EmptyLoginException()],
    );
  }

  Future<void> validatePassword(String password) async {
    if (state is SignInError) {
      emit(
        (state as SignInError).copyWith(
          passwordException: null,
          signInException: null,
        ),
      );
    }
    await _validateField<PasswordException>(
      result: _validatePasswordUseCase(
        ValidatePasswordPayload(password: password),
      ),
      getException: (result) => result.exception as PasswordException?,
      updateError: (state, exception) =>
          state.copyWith(passwordException: exception),
      validatedExceptions: [EmptyPasswordException()],
    );
  }

  Future<void> _validateField<T>({
    required Result result,
    required T? Function(Failure result) getException,
    required SignInError Function(SignInError state, T? exception) updateError,
    required List<Exception> validatedExceptions,
  }) async {
    if (result is Failure) {
      final exception = getException(result);

      var isValidated = false;
      for (final validatedException in validatedExceptions) {
        if (exception.runtimeType == validatedException.runtimeType) {
          isValidated = true;
          break;
        }
      }
      if (!isValidated) return;

      if (state is SignInError) {
        emit(updateError(state as SignInError, exception));
      } else {
        emit(updateError(SignInError(), exception));
      }
    }
  }

  Future<void> signIn(String login, String password) async {
    emit(SignInLoading());

    await validateLogin(login);
    await validatePassword(password);

    if (state is SignInError) return;

    final result = await _signInUseCase(
      SignInPayload(login: login, password: password),
    );

    if (result is Success) {
      emit(SignInSuccess());
    } else if (result is Failure) {
      final exception = result.exception;

      emit(SignInError(signInException: exception as SignInException?));
    }
  }
}
