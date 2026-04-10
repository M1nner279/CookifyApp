import 'package:cookify/feature/auth/sign_in/domain/payloads/safe_sign_in_payload.dart';
import 'package:cookify/feature/auth/sign_in/domain/repositories/sign_in_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  @override
  Future<bool> signIn(SafeSignInPayload safeSignInPayload) {
    return Future.value(true);
  }
}