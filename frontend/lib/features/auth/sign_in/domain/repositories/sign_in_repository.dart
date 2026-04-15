import 'package:cookify/features/auth/sign_in/domain/payloads/sign_in_payload.dart';

abstract interface class SignInRepository {
  Future<void> signIn(SignInPayload payload);
}
