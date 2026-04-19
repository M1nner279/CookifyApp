import 'package:cookify/features/auth/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

abstract interface class SignInRepository {
  Future<Token> signIn(SignInPayload payload);
}
