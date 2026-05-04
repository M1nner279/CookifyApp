import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/sign_up/domain/payloads/sign_up_payload.dart';

abstract interface class SignUpRepository {
  Future<MyEither<void>> signUp(SignUpPayload payload);
}
