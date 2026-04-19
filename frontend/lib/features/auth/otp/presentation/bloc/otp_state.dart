import 'package:cookify/features/auth/otp/domain/exceptions/otp_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_state.freezed.dart';

@freezed
sealed class OtpState with _$OtpState {
  const factory OtpState.initial({@Default(0) int remainingSeconds}) =
      OtpInitial;

  const factory OtpState.loading({@Default(0) int remainingSeconds}) =
      OtpLoading;

  const factory OtpState.success() = OtpSuccess;

  const factory OtpState.error({
    OtpException? otpException,
    @Default(0) int remainingSeconds,
  }) = OtpError;
}
