import 'package:cookify/feature/auth/domain/usecase/authorize.dart';
import 'package:cookify/feature/auth/domain/usecase/login.dart';
import 'package:cookify/feature/auth/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this._authorize, required this._login})
    : super(const LoginInitial());

  final Authorize _authorize;
  final Login _login;

  Future<void> authorize() async {
    emit(LoginLoading());

    final isAuthorizedOrFailure = await _authorize();

    if (!isClosed) {
      emit(
        isAuthorizedOrFailure.fold((failure) => LoginUnauthorized(), (
          isAuthorized,
        ) {
          return isAuthorized ? LoginAuthorized() : LoginUnauthorized();
        }),
      );
    }
  }

  Future<void> login(String name, String password) async {
    emit((state as LoginUnauthorized).copyWith(isLoading: true, failure: null));

    final successOrFailure = await _login(name, password);

    if (!isClosed) {
      emit(
        successOrFailure.fold(
          (failure) => LoginUnauthorized(failure: failure),
          (_) => LoginAuthorized(),
        ),
      );
    }
  }
}
