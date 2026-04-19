import 'package:cookify/features/auth/auth_common/domain/exceptions/confirm_password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
sealed class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState.initial() = ChangePasswordInitial;

  const factory ChangePasswordState.loading() = ChangePasswordLoading;

  const factory ChangePasswordState.success() = ChangePasswordSuccess;

  const factory ChangePasswordState.error({
    PasswordException? passwordException,
    ConfirmPasswordException? confirmPasswordException,
  }) = ChangePasswordError;
}
