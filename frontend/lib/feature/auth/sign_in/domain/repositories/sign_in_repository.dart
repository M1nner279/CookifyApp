import 'package:cookify/feature/auth/sign_in/domain/payloads/safe_sign_in_payload.dart';

abstract interface class SignInRepository {
  Future<bool> signIn(SafeSignInPayload safeSignInPayload);
}
