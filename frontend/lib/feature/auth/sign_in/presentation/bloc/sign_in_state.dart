import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = SignInInitial;

  const factory SignInState.loading() = SignInLoading;

  const factory SignInState.success() = SignInSuccess;

  const factory SignInState.error() = SignInError;
}
