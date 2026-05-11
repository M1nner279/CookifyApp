import 'dart:async';

import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:cookify/core/presentation/widgets/app_toast.dart';
import 'package:cookify/di/di.dart';
import 'package:cookify/features/sign_in/dependecies/sign_in_dependency.dart';
import 'package:cookify/features/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:cookify/features/sign_in/navigators/sign_in_navigator.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:cookify/features/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required SignInNavigator signInNavigator,
    required SignInDependency signInDependency,
    required SignInUseCase signInUseCase,
  }) : _signInNavigator = signInNavigator,
       _signInDependency = signInDependency,
       _signInUseCase = signInUseCase,
       super(const SignInState()) {
    on<ValidateLogin>(_onValidateLogin);
    on<ValidatePassword>(_onValidatePassword);
    on<SignIn>(_onSignIn);
    on<SignInWithGoogle>(_onSignInWithGoogle);
  }

  SignInNavigator? _signInNavigator;
  final SignInDependency _signInDependency;
  final SignInUseCase _signInUseCase;

  FutureOr<void> _onValidateLogin(
    ValidateLogin event,
    Emitter<SignInState> emit,
  ) async {
    _validateLogin(event.login, emit);
  }

  void _validateLogin(String login, Emitter<SignInState> emit) {
    final result = _signInDependency.validateLogin(login);
    emit(
      state.copyWith(
        login: LocalizedErrorValue(value: login, localizeError: result),
      ),
    );
  }

  FutureOr<void> _onValidatePassword(
    ValidatePassword event,
    Emitter<SignInState> emit,
  ) async {
    _validatePassword(event.password, emit);
  }

  void _validatePassword(String password, Emitter<SignInState> emit) {
    final result = _signInDependency.validatePassword(password);
    emit(
      state.copyWith(
        password: LocalizedErrorValue(value: password, localizeError: result),
      ),
    );
  }

  FutureOr<void> _onSignIn(SignInEvent event, Emitter<SignInState> emit) async {
    _validateLogin(state.login.value, emit);
    _validatePassword(state.password.value, emit);
    if (state.login.localizeError != null ||
        state.password.localizeError != null) {
      return;
    }

    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await _signInUseCase(
      SignInPayload(login: state.login.value, password: state.password.value),
    );
    if (isClosed) return;

    result.fold(
      (failure) {
        if (failure is NetworkFailure) {
          showToast(false, 'Нет подключения к интернету');
        } else if (failure is UnknownFailure) {
          showToast(false, 'Повторите попытку');
        }
        emit(state.copyWith(isLoading: false, hasError: true));
      },
      (token) async {
        await _signInDependency.setToken(token);
        _signInNavigator?.goRecipeFeed();
      },
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '139854363821-gv5jnts7t67e8mpm2a1erv6fu84gd8nr.apps.googleusercontent.com',
  );

  Future<void> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;

        final String? idToken = auth.idToken;

        final response = await Di.dio.post(
          '/api/google',
          data: {'id_token': idToken},
        );
        final token = TokenMapper.toEntity(TokenModel.fromJson(response.data));

        await _signInDependency.setToken(token);
        _signInNavigator?.goRecipeFeed();
      }
    } catch (error) {
      print('Ошибка входа: $error');
    }
  }

  FutureOr<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<SignInState> emit,
  ) async {
    await signInWithGoogle();
  }

  @override
  Future<void> close() async {
    _signInNavigator = null;
    return super.close();
  }
}
