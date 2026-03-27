import 'package:cookify/config/error/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;

  const factory LoginState.loading() = LoginLoading;

  const factory LoginState.unauthorized({
    @Default(false) bool isLoading,
    Failure? failure,
  }) = LoginUnauthorized;

  const factory LoginState.authorized() = LoginAuthorized;
}
