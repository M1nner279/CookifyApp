import 'dart:async';

import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:cookify/di/di.dart';
import 'package:cookify/features/sign_up/dependencies/sign_up_dependency.dart';
import 'package:cookify/features/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/features/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:cookify/features/sign_up/navigators/sign_up_navigator.dart';
import 'package:cookify/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:cookify/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/di/token_di.dart';
import 'package:cookify/features/token/domain/payloads/set_token_payload.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required SignUpNavigator signUpNavigator,
    required SignUpDependency signUpDependency,
    required SignUpUseCase signUpUseCase,
  }) : _signUpNavigator = signUpNavigator,
       _signUpDependency = signUpDependency,
       _signUpUseCase = signUpUseCase,
       super(const SignUpState()) {
    on<ValidateLogin>(_onValidateLogin);
    on<ValidateEmail>(_onValidateEmail);
    on<ValidatePassword>(_onValidatePassword);
    on<ValidateConfirmPassword>(_onValidateConfirmPassword);
    on<SignUp>(_onSignUp);
  }

  SignUpNavigator? _signUpNavigator;
  final SignUpDependency _signUpDependency;
  final SignUpUseCase _signUpUseCase;

  FutureOr<void> _onValidateLogin(
    ValidateLogin event,
    Emitter<SignUpState> emit,
  ) async {
    _validateLogin(event.login, emit);
  }

  void _validateLogin(String login, Emitter<SignUpState> emit) {
    final result = _signUpDependency.validateLogin(login);
    emit(
      state.copyWith(
        login: LocalizedErrorValue(value: login, localizeError: result),
      ),
    );
  }

  FutureOr<void> _onValidateEmail(
    ValidateEmail event,
    Emitter<SignUpState> emit,
  ) async {
    _validateEmail(event.email, emit);
  }

  void _validateEmail(String email, Emitter<SignUpState> emit) {
    final result = _signUpDependency.validateEmail(email);
    emit(
      state.copyWith(
        email: LocalizedErrorValue(value: email, localizeError: result),
      ),
    );
  }

  FutureOr<void> _onValidatePassword(
    ValidatePassword event,
    Emitter<SignUpState> emit,
  ) async {
    _validatePassword(event.password, emit);
  }

  void _validatePassword(String password, Emitter<SignUpState> emit) {
    final result = _signUpDependency.validatePassword(password);
    emit(
      state.copyWith(
        password: LocalizedErrorValue(value: password, localizeError: result),
      ),
    );
  }

  FutureOr<void> _onValidateConfirmPassword(
    ValidateConfirmPassword event,
    Emitter<SignUpState> emit,
  ) async {
    _validateConfirmPassword(state.password.value, event.confirmPassword, emit);
  }

  void _validateConfirmPassword(
    String password,
    String confirmPassword,
    Emitter<SignUpState> emit,
  ) {
    final result = _signUpDependency.validateConfirmPassword(
      password,
      confirmPassword,
    );
    emit(
      state.copyWith(
        confirmPassword: LocalizedErrorValue(
          value: confirmPassword,
          localizeError: result,
        ),
      ),
    );
  }

  FutureOr<void> _onSignUp(SignUpEvent event, Emitter<SignUpState> emit) async {
    _validateLogin(state.login.value, emit);
    _validateEmail(state.email.value, emit);
    _validatePassword(state.password.value, emit);
    _validateConfirmPassword(
      state.password.value,
      state.confirmPassword.value,
      emit,
    );
    if (state.login.localizeError != null ||
        state.email.localizeError != null ||
        state.password.localizeError != null ||
        state.confirmPassword.localizeError != null) {
      return;
    }

    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _signUpUseCase(
      SignUpPayload(
        login: state.login.value,
        email: state.email.value,
        password: state.password.value,
      ),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (_) {
        _signUpNavigator?.goOtp(state.email.value);
      },
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '139854363821-gv5jnts7t67e8mpm2a1erv6fu84gd8nr.apps.googleusercontent.com',
  );

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;

        final String? idToken = auth.idToken;

        final response = await Di.dio.post('/api/google', data: {'id_token': idToken});
        final token = TokenMapper.toEntity(TokenModel.fromJson(response.data));

        await TokenDi.setTokenUseCase(SetTokenPayload(token: token));
        _signUpNavigator?.goRecipeFeed();
      }
    } catch (error) {
      print('Ошибка входа: $error');
    }
  }

  FutureOr<void> _onSignUpWithGoogle(
    SignUpWithGoogle event,
    Emitter<SignUpState> emit,
  ) async {
    await signInWithGoogle();
  }

  @override
  Future<void> close() async {
    _signUpNavigator = null;
    return super.close();
  }
}
