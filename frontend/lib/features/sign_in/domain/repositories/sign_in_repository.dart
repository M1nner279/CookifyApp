import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

abstract interface class SignInRepository {
  Future<MyEither<Token>> signIn(SignInPayload payload);
}
