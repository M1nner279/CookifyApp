import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.freezed.dart';

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.validateLogin({required String login}) =
      ValidateLogin;

  const factory SignUpEvent.validateEmail({required String email}) =
      ValidateEmail;

  const factory SignUpEvent.validatePassword({required String password}) =
      ValidatePassword;

  const factory SignUpEvent.validateConfirmPassword({
    required String confirmPassword,
  }) = ValidateConfirmPassword;

  const factory SignUpEvent.signUp() = SignUp;

  const factory SignUpEvent.signUpWithGoogle() = SignUpWithGoogle;
}
