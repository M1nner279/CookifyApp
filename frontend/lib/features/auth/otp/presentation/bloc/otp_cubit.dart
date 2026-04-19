import 'dart:async';
import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/otp/domain/exceptions/otp_exception.dart';
import 'package:cookify/features/auth/otp/domain/payloads/confirm_code_payload.dart';
import 'package:cookify/features/auth/otp/domain/payloads/resend_code_payload.dart';
import 'package:cookify/features/auth/otp/domain/use_cases/confirm_code_use_case.dart';
import 'package:cookify/features/auth/otp/domain/use_cases/resend_code_use_case.dart';
import 'package:cookify/features/auth/otp/presentation/bloc/otp_state.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/payloads/save_token_payload.dart';
import 'package:cookify/features/token/domain/use_cases/save_token_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({
    required String login,
    required ConfirmCodeUseCase confirmCodeUseCase,
    required ResendCodeUseCase resendCodeUseCase,
    required SaveTokenUseCase saveTokenUseCase,
    this.initialTimerSeconds = 30,
  }) : _login = login,
       _confirmCodeUseCase = confirmCodeUseCase,
       _resendCodeUseCase = resendCodeUseCase,
       _saveTokenUseCase = saveTokenUseCase,
       super(OtpInitial()) {
    _startTimer();
  }

  final String _login;
  final ConfirmCodeUseCase _confirmCodeUseCase;
  final ResendCodeUseCase _resendCodeUseCase;
  final SaveTokenUseCase _saveTokenUseCase;
  final int initialTimerSeconds;

  Timer? _timer;
  int _remainingSeconds = 0;

  int get remainingSeconds => _remainingSeconds;

  bool get canResendCode => _remainingSeconds == 0;

  Future<void> confirmCode(String code) async {
    emit(OtpLoading());

    final result = await _confirmCodeUseCase(
      ConfirmCodePayload(login: _login, code: code),
    );

    if (result is Success<Token>) {
      _cancelTimer();
      await _saveTokenUseCase(SaveTokenPayload(token: result.data));
      emit(OtpSuccess());
    } else if (result is Failure<Token>) {
      final exception = result.exception;
      emit(OtpError(otpException: exception as OtpException?));
    }
  }

  Future<void> resendCode() async {
    if (!canResendCode) {
      return;
    }

    await resetState();

    final result = await _resendCodeUseCase(ResendCodePayload(login: _login));

    if (result is Success) {
      _startTimer();
    } else if (result is Failure) {
      emit(OtpError(otpException: result.exception as OtpException?));
    }
  }

  Future<void> resetState() async {
    _cancelTimer();
    _remainingSeconds = 0;
    emit(OtpInitial());
    _startTimer();
  }

  void _startTimer() {
    _cancelTimer();
    _remainingSeconds = initialTimerSeconds;
    _emitTimerState();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _emitTimerState();
      } else {
        _cancelTimer();
        _emitTimerState();
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _emitTimerState() {
    final currentState = state;

    if (currentState is OtpInitial) {
      emit(currentState.copyWith(remainingSeconds: _remainingSeconds));
    } else if (currentState is OtpError) {
      emit(currentState.copyWith(remainingSeconds: _remainingSeconds));
    } else if (currentState is OtpLoading) {
      emit(currentState.copyWith(remainingSeconds: _remainingSeconds));
    } else if (currentState is OtpSuccess) {
      return;
    }
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}
