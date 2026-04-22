import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/confirm_password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_confirm_password_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_password_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/features/auth/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/features/auth/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:cookify/features/auth/change_password/presentation/bloc/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required ValidatePasswordUseCase validatePasswordUseCase,
    required ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
  }) : _validatePasswordUseCase = validatePasswordUseCase,
       _validateConfirmPasswordUseCase = validateConfirmPasswordUseCase,
       _changePasswordUseCase = changePasswordUseCase,
       super(ChangePasswordInitial());

  final ValidatePasswordUseCase _validatePasswordUseCase;
  final ValidateConfirmPasswordUseCase _validateConfirmPasswordUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  Future<void> validatePassword(String password) async {
    if (state is ChangePasswordError) {
      emit((state as ChangePasswordError).copyWith(passwordException: null));
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
    if (state is ChangePasswordError) {
      emit(
        (state as ChangePasswordError).copyWith(confirmPasswordException: null),
      );
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
    required ChangePasswordError Function(
      ChangePasswordError state,
      T? exception,
    )
    updateError,
  }) async {
    if (result is Failure) {
      final exception = getException(result);

      if (state is ChangePasswordError) {
        emit(updateError(state as ChangePasswordError, exception));
      } else {
        emit(updateError(ChangePasswordError(), exception));
      }
    }
  }

  Future<void> changePassword(String password, String confirmPassword) async {
    emit(ChangePasswordLoading());

    await validatePassword(password);
    await validateConfirmPassword(password, confirmPassword);

    if (state is ChangePasswordError) return;

    final result = await _changePasswordUseCase(
      ChangePasswordPayload(password: password),
    );

    if (result is Success) {
      emit(ChangePasswordSuccess());
    } else if (result is Failure) {
      emit(ChangePasswordError());
    }
  }
}
