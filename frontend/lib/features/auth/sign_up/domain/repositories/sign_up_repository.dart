import 'package:cookify/features/auth/sign_up/domain/payloads/sign_up_payload.dart';

abstract interface class SignUpRepository {
  Future<void> signUp(SignUpPayload payload);
}
