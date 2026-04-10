import 'package:cookify/feature/auth/sign_up/domain/payloads/resend_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/payloads/safe_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/payloads/verify_sign_up_payload.dart';

abstract interface class SignUpRepository {
  Future<bool> signUp(SafeSignUpPayload safeSignUpPayload);

  Future<bool> verifyCode(VerifySignUpPayload verifySignUpPayload);

  Future<void> resendCode(ResendSignUpPayload resendSignUpPayload);
}
