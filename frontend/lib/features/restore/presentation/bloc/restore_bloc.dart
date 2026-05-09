import 'dart:async';

import 'package:cookify/core/domain/failures/failures.dart';
import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:cookify/core/presentation/widgets/app_toast.dart';
import 'package:cookify/features/restore/dependencies/restore_dependency.dart';
import 'package:cookify/features/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/features/restore/domain/use_cases/restore_use_case.dart';
import 'package:cookify/features/restore/navigators/restore_navigator.dart';
import 'package:cookify/features/restore/presentation/bloc/restore_event.dart';
import 'package:cookify/features/restore/presentation/bloc/restore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestoreBloc extends Bloc<RestoreEvent, RestoreState> {
  RestoreBloc({
    required RestoreNavigator restoreNavigator,
    required RestoreDependency restoreDependency,
    required RestoreUseCase restoreUseCase,
  }) : _restoreNavigator = restoreNavigator,
       _restoreDependency = restoreDependency,
       _restoreUseCase = restoreUseCase,
       super(const RestoreState()) {
    on<ValidateLogin>(_onValidateLogin);
    on<Restore>(_onRestore);
  }

  RestoreNavigator? _restoreNavigator;
  final RestoreDependency _restoreDependency;
  final RestoreUseCase _restoreUseCase;

  FutureOr<void> _onValidateLogin(
    ValidateLogin event,
    Emitter<RestoreState> emit,
  ) async {
    _validateLogin(event.login, emit);
  }

  void _validateLogin(String login, Emitter<RestoreState> emit) {
    final result =
        _restoreDependency.validateLogin(login) ??
        _restoreDependency.validateEmail(login);
    emit(
      state.copyWith(
        login: LocalizedErrorValue(value: login, localizeError: result),
      ),
    );
  }

  FutureOr<void> _onRestore(
    RestoreEvent event,
    Emitter<RestoreState> emit,
  ) async {
    _validateLogin(state.login.value, emit);
    if (state.login.localizeError != null) {
      return;
    }

    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await _restoreUseCase(
      RestorePayload(login: state.login.value),
    );
    result.fold((failure) {
      emit(state.copyWith(hasError: true));
      if (failure is NetworkFailure) {
        showToast(false, 'Нет подключения к интернету');
      } else if (failure is UnknownFailure) {
        showToast(false, 'Повторите попытку');
      }
    }, (_) => _restoreNavigator?.goOtp(state.login.value));
  }

  @override
  Future<void> close() async {
    _restoreNavigator = null;
    return super.close();
  }
}
