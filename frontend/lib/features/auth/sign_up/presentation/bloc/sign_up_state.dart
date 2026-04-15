import 'package:cookify/features/auth/auth_common/domain/exceptions/confirm_password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/email_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/sign_up/domain/exceptions/sign_up_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = SignUpInitial;

  const factory SignUpState.loading() = SignUpLoading;

  const factory SignUpState.success() = SignUpSuccess;

  const factory SignUpState.error({
    LoginException? loginException,
    EmailException? emailException,
    PasswordException? passwordException,
    ConfirmPasswordException? confirmPasswordException,
    SignUpException? signUpException,
  }) = SignUpError;
}
