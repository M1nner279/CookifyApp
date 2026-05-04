import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(LocalizedErrorValue(value: '')) LocalizedErrorValue login,
    @Default(LocalizedErrorValue(value: '')) LocalizedErrorValue email,
    @Default(LocalizedErrorValue(value: '')) LocalizedErrorValue password,
    @Default(LocalizedErrorValue(value: ''))
    LocalizedErrorValue confirmPassword,
    @Default(false) bool isLoading,
    Failure? failure,
  }) = _SignUpState;
}
