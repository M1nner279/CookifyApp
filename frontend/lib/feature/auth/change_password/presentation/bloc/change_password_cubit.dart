import 'package:cookify/feature/auth/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/feature/auth/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:cookify/feature/auth/change_password/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/feature/auth/change_password/domain/use_cases/validate_new_password_use_case.dart';
import 'package:cookify/feature/auth/change_password/presentation/bloc/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required ValidateNewPasswordUseCase validateNewPasswordUseCase,
    required ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
  })  : _validateNewPasswordUseCase = validateNewPasswordUseCase,
        _validateConfirmPasswordUseCase = validateConfirmPasswordUseCase,
        _changePasswordUseCase = changePasswordUseCase,
        super(const ChangePasswordInitial());

  final ValidateNewPasswordUseCase _validateNewPasswordUseCase;
  final ValidateConfirmPasswordUseCase _validateConfirmPasswordUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  Future<void> changePassword(
    String newPassword,
    String confirmPassword,
  ) async {
    emit(const ChangePasswordLoading());

    if (!_validateNewPasswordUseCase(newPassword)) {
      emit(
        state is ChangePasswordError
            ? (state as ChangePasswordError).copyWith(hasPasswordError: true)
            : const ChangePasswordError(hasPasswordError: true),
      );
    }
    if (!_validateConfirmPasswordUseCase(newPassword, confirmPassword)) {
      emit(
        state is ChangePasswordError
            ? (state as ChangePasswordError).copyWith(hasConfirmPasswordError: true)
            : const ChangePasswordError(hasConfirmPasswordError: true),
      );
    }
    if (state is ChangePasswordError) {
      return;
    }

    final result = await _changePasswordUseCase(
      ChangePasswordPayload(newPassword: newPassword),
    );

    if (!isClosed) {
      emit(result
          ? const ChangePasswordSuccess()
          : const ChangePasswordError());
    }
  }
}