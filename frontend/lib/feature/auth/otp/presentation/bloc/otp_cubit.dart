import 'dart:async';
import 'package:cookify/feature/auth/otp/presentation/bloc/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit({
    required Future<bool> Function(String) verifyCode,
    required void Function() resendCode,
    int initialCooldownSeconds = 60,
  }) : _verifyCode = verifyCode,
       _resendCode = resendCode,
       super(OtpInitial(remainingSeconds: initialCooldownSeconds));

  final Future<bool> Function(String code) _verifyCode;
  final void Function() _resendCode;
  
  Timer? _timer;
  int _cooldownSeconds = 60;

  Future<void> verifyCode(String code) async {
    if (state is OtpLoading) return; 
    
    emit(OtpLoading(state.remainingSeconds));

    if (await _verifyCode(code)) {
      emit(OtpSuccess(
        message: 'success',
        remainingSeconds: state.remainingSeconds,
        initialCooldownSeconds: state.initialCooldownSeconds,
      ));
    } else {
      emit(OtpError(
        error: 'error',
        remainingSeconds: state.remainingSeconds,
        initialCooldownSeconds: state.initialCooldownSeconds,
      ));
    }
  }

  void resendCode() {
    // Нельзя отправить, если таймер еще идет
    if (_isOnCooldown) return;
    
    emit(OtpLoading(state.remainingSeconds));
    _resendCode();
    _startCooldown();
  }

  void _startCooldown() {
    _cancelTimer();
    
    _cooldownSeconds = state.initialCooldownSeconds;
    emit(OtpCooldown(
      remainingSeconds: _cooldownSeconds,
      initialCooldownSeconds: state.initialCooldownSeconds,
    ));
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_cooldownSeconds <= 1) {
        _cancelTimer();
        emit(OtpReady(
          remainingSeconds: 0,
          initialCooldownSeconds: state.initialCooldownSeconds,
        ));
      } else {
        _cooldownSeconds--;
        emit(OtpCooldown(
          remainingSeconds: _cooldownSeconds,
          initialCooldownSeconds: state.initialCooldownSeconds,
        ));
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  bool get _isOnCooldown {
    final currentState = state;
    return currentState is OtpCooldown && currentState.remainingSeconds > 0;
  }

  void setError(String error) {
    emit(OtpError(
      error: error,
      remainingSeconds: state.remainingSeconds,
      initialCooldownSeconds: state.initialCooldownSeconds,
    ));
  }

  void setSuccess(String message) {
    emit(OtpSuccess(
      message: message,
      remainingSeconds: state.remainingSeconds,
      initialCooldownSeconds: state.initialCooldownSeconds,
    ));
  }

  void reset() {
    _cancelTimer();
    emit(OtpInitial(remainingSeconds: state.initialCooldownSeconds));
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}