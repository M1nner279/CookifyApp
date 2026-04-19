import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_login_payload.dart';
import 'package:cookify/features/auth/auth_common/domain/use_cases/validate_login_use_case.dart';
import 'package:cookify/features/auth/restore/domain/exceptions/restore_exception.dart';
import 'package:cookify/features/auth/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/features/auth/restore/domain/use_cases/restore_use_case.dart';
import 'package:cookify/features/auth/restore/presentation/bloc/restore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreCubit extends Cubit<RestoreState> {
  RestoreCubit({
    required ValidateLoginUseCase validateLoginUseCase,
    required RestoreUseCase restoreUseCase,
  }) : _validateLoginUseCase = validateLoginUseCase,
       _restoreUseCase = restoreUseCase,
       super(RestoreInitial());

  final ValidateLoginUseCase _validateLoginUseCase;
  final RestoreUseCase _restoreUseCase;

  Future<void> validateLogin(String login) async {
    if (state is RestoreError) {
      emit(
        (state as RestoreError).copyWith(
          loginException: null,
          restoreException: null,
        ),
      );
    }
    await _validateField<LoginException>(
      result: _validateLoginUseCase(ValidateLoginPayload(login: login)),
      getException: (result) => result.exception as LoginException?,
      updateError: (state, exception) =>
          state.copyWith(loginException: exception),
      validatedExceptions: [EmptyLoginException()],
    );
  }

  Future<void> _validateField<T>({
    required Result result,
    required T? Function(Failure result) getException,
    required RestoreError Function(RestoreError state, T? exception)
    updateError,
    required List<Exception> validatedExceptions,
  }) async {
    if (result is Failure) {
      final exception = getException(result);

      var isValidated = false;
      for (final validatedException in validatedExceptions) {
        if (exception.runtimeType == validatedException.runtimeType) {
          isValidated = true;
          break;
        }
      }
      if (!isValidated) return;

      if (state is RestoreError) {
        emit(updateError(state as RestoreError, exception));
      } else {
        emit(updateError(RestoreError(), exception));
      }
    }
  }

  Future<void> restore(String login) async {
    emit(RestoreLoading());

    await validateLogin(login);

    if (state is RestoreError) return;

    final result = await _restoreUseCase(RestorePayload(login: login));

    if (result is Success) {
      emit(RestoreSuccess());
    } else if (result is Failure) {
      final exception = result.exception;

      emit(RestoreError(restoreException: exception as RestoreException?));
    }
  }
}
