import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/otp/domain/payloads/confirm_code_payload.dart';
import 'package:cookify/features/otp/domain/payloads/resend_code_payload.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

abstract interface class OtpRepository {
  Future<MyEither<Token>> confirmCode(ConfirmCodePayload payload);

  Future<MyEither<void>> resendCode(ResendCodePayload payload);
}
