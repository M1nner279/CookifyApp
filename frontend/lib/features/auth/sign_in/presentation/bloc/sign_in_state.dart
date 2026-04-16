import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/sign_in/domain/exceptions/sign_in_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = SignInInitial;

  const factory SignInState.loading() = SignInLoading;

  const factory SignInState.success() = SignInSuccess;

  const factory SignInState.error({
    LoginException? loginException,
    PasswordException? passwordException,
    SignInException? signInException,
  }) = SignInError;
}
