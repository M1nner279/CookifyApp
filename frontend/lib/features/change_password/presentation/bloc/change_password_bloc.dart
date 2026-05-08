import 'dart:async';

import 'package:cookify/core/presentation/localize/localized_error_value.dart';
import 'package:cookify/features/change_password/dependencies/change_password_dependency.dart';
import 'package:cookify/features/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:cookify/features/change_password/navigators/change_password_navigator.dart';
import 'package:cookify/features/change_password/presentation/bloc/change_password_event.dart';
import 'package:cookify/features/change_password/presentation/bloc/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({
    required ChangePasswordNavigator changePasswordNavigator,
    required ChangePasswordDependency changePasswordDependency,
    required ChangePasswordUseCase changePasswordUseCase,
    required Function goNext,
  }) : _changePasswordNavigator = changePasswordNavigator,
       _changePasswordDependency = changePasswordDependency,
       _changePasswordUseCase = changePasswordUseCase,
       _goNext = goNext,
       super(const ChangePasswordState()) {
    on<ValidatePassword>(_onValidatePassword);
    on<ValidateConfirmPassword>(_onValidateConfirmPassword);
    on<ChangePassword>(_onChangePassword);
    on<Pop>(_onPop);
  }

  ChangePasswordNavigator? _changePasswordNavigator;
  final ChangePasswordDependency _changePasswordDependency;
  final ChangePasswordUseCase _changePasswordUseCase;
  final Function _goNext;

  FutureOr<void> _onValidatePassword(
    ValidatePassword event,
    Emitter<ChangePasswordState> emit,
  ) async {
    _validatePassword(event.password, emit);
  }

  void _validatePassword(String password, Emitter<ChangePasswordState> emit) {
    final result = _changePasswordDependency.validatePassword(password);
    emit(
      state.copyWith(
        password: LocalizedErrorValue(value: password, localizeError: result),
      ),
    );
  }

  FutureOr<void> _onValidateConfirmPassword(
    ValidateConfirmPassword event,
    Emitter<ChangePasswordState> emit,
  ) async {
    _validateConfirmPassword(state.password.value, event.confirmPassword, emit);
  }

  void _validateConfirmPassword(
    String password,
    String confirmPassword,
    Emitter<ChangePasswordState> emit,
  ) {
    final result = _changePasswordDependency.validateConfirmPassword(
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

  FutureOr<void> _onChangePassword(
    ChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    _validatePassword(state.password.value, emit);
    _validateConfirmPassword(
      state.password.value,
      state.confirmPassword.value,
      emit,
    );
    if (state.password.localizeError != null ||
        state.confirmPassword.localizeError != null) {
      return;
    }

    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await _changePasswordUseCase(
      ChangePasswordPayload(password: state.password.value),
    );
    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, hasError: true)),
      (_) {
        _goNext();
      },
    );
  }

  FutureOr<void> _onPop(Pop event, Emitter<ChangePasswordState> emit) {
    _changePasswordNavigator?.pop();
  }

  @override
  Future<void> close() async {
    _changePasswordNavigator = null;
    return super.close();
  }
}
