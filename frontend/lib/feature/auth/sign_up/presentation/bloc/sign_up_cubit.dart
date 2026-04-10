import 'package:cookify/feature/auth/sign_up/domain/payloads/resend_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/payloads/verify_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/resend_sign_up_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_confirm_password_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_email_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/validate_password_use_case.dart';
import 'package:cookify/feature/auth/sign_up/domain/use_cases/verify_sign_up_use_case.dart';
import 'package:cookify/feature/auth/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required ValidateLoginUseCase validateLoginUseCase,
    required ValidateEmailUseCase validateEmailUseCase,
    required ValidatePasswordUseCase validatePasswordUseCase,
    required ValidateConfirmPasswordUseCase validateConfirmPasswordUseCase,
    required SignUpUseCase signUpUseCase,
    required VerifySignUpUseCase verifySignUpUseCase,
    required ResendSignUpUseCase resendSignUpUseCase,
  }) : _validateLoginUseCase = validateLoginUseCase,
       _validateEmailUseCase = validateEmailUseCase,
       _validatePasswordUseCase = validatePasswordUseCase,
       _validateConfirmPasswordUseCase = validateConfirmPasswordUseCase,
       _signUpUseCase = signUpUseCase,
       _verifySignUpUseCase = verifySignUpUseCase,
       _resendSignUpUseCase = resendSignUpUseCase,
       super(SignUpInitial());

  final ValidateLoginUseCase _validateLoginUseCase;
  final ValidateEmailUseCase _validateEmailUseCase;
  final ValidatePasswordUseCase _validatePasswordUseCase;
  final ValidateConfirmPasswordUseCase _validateConfirmPasswordUseCase;
  final SignUpUseCase _signUpUseCase;
  final VerifySignUpUseCase _verifySignUpUseCase;
  final ResendSignUpUseCase _resendSignUpUseCase;
  String? _email;

  Future<void> signUp(
    String login,
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(const SignUpLoading());

    if (!_validateLoginUseCase(login)) {
      emit(
        state is SignUpError
            ? (state as SignUpError).copyWith(hasLoginError: true)
            : const SignUpError(hasLoginError: true),
      );
    }
    if (!_validateEmailUseCase(email)) {
      emit(
        state is SignUpError
            ? (state as SignUpError).copyWith(hasEmailError: true)
            : const SignUpError(hasEmailError: true),
      );
    }
    if (!_validatePasswordUseCase(password)) {
      emit(
        state is SignUpError
            ? (state as SignUpError).copyWith(hasPasswordError: true)
            : const SignUpError(hasPasswordError: true),
      );
    }
    if (!_validateConfirmPasswordUseCase(password, confirmPassword)) {
      emit(
        state is SignUpError
            ? (state as SignUpError).copyWith(hasConfirmPasswordError: true)
            : const SignUpError(hasConfirmPasswordError: true),
      );
    }
    if (state is SignUpError) {
      return;
    }

    final result = await _signUpUseCase(
      SignUpPayload(login: login, email: email, password: password),
    );

    if (!isClosed) {
      emit(result ? const SignUpSuccess() : const SignUpError());
      _email = email;
    }
  }

  Future<bool> verifyCode(String code) {
    return _verifySignUpUseCase(
      VerifySignUpPayload(email: _email!, code: code),
    );
  }

  Future<void> resendCode() {
    return _resendSignUpUseCase(ResendSignUpPayload(email: _email!));
  }
}
