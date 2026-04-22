import 'package:cookify/features/auth/otp/domain/payloads/confirm_code_payload.dart';
import 'package:cookify/features/auth/otp/domain/payloads/resend_code_payload.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

abstract interface class OtpRepository {
  Future<Token> confirmCode(ConfirmCodePayload payload);

  Future<void> resendCode(ResendCodePayload payload);
}
