import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_event.freezed.dart';

@freezed
sealed class ChangePasswordEvent with _$ChangePasswordEvent {
  const factory ChangePasswordEvent.validatePassword({
    required String password,
  }) = ValidatePassword;

  const factory ChangePasswordEvent.validateConfirmPassword({
    required String confirmPassword,
  }) = ValidateConfirmPassword;

  const factory ChangePasswordEvent.changePassword() = ChangePassword;

  const factory ChangePasswordEvent.pop() = Pop;
}
