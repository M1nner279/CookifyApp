import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_event.freezed.dart';

@freezed
sealed class OtpEvent with _$OtpEvent {
  const factory OtpEvent.confirmCode(String code) = _ConfirmCode;

  const factory OtpEvent.resendCode() = _ResendCode;

  const factory OtpEvent.pop() = _Pop;}
