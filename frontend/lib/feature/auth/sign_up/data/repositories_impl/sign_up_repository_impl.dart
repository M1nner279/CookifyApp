import 'package:cookify/feature/auth/sign_up/domain/payloads/resend_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/payloads/safe_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/payloads/verify_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  @override
  Future<bool> signUp(SafeSignUpPayload safeSignUpPayload) {
    return Future.value(true);
  }

  @override
  Future<bool> verifyCode(VerifySignUpPayload verifySignUpPayload) {
    // TODO: implement verifyCode
    throw UnimplementedError();
  }

  @override
  Future<void> resendCode(ResendSignUpPayload resendSignUpPayload) {
    // TODO: implement resendCode
    throw UnimplementedError();
  }
}