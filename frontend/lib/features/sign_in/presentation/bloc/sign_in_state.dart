import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState({
    @Default(LocalizedErrorValue(value: '')) LocalizedErrorValue login,
    @Default(LocalizedErrorValue(value: '')) LocalizedErrorValue password,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
  }) = _SignInState;
}
