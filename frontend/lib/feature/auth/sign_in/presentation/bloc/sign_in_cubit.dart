import 'package:cookify/feature/auth/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/feature/auth/sign_in/domain/use_cases/sign_in_use_case.dart';
import 'package:cookify/feature/auth/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required SignInUseCase signInUseCase})
    : _signInUseCase = signInUseCase,
      super(SignInInitial());

  final SignInUseCase _signInUseCase;

  Future<void> signIn(String login, String password) async {
    emit(const SignInLoading());

    final result = await _signInUseCase(
      SignInPayload(login: login, password: password),
    );

    if (!isClosed) {
      emit(result ? const SignInSuccess() : const SignInError());
    }
  }
}
