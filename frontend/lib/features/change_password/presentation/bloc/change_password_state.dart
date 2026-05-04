import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_state.freezed.dart';

@freezed
sealed class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(LocalizedErrorValue(value: ''))
    LocalizedErrorValue<String> password,
    @Default(LocalizedErrorValue(value: ''))
    LocalizedErrorValue<String> confirmPassword,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
  }) = _ChangePasswordState;
}
