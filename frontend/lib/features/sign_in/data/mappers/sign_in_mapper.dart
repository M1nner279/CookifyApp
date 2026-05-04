import 'package:cookify/features/sign_in/data/requests/sign_in_request.dart';
import 'package:cookify/features/sign_in/domain/payloads/sign_in_payload.dart';

abstract class SignInMapper {
  static SignInRequest toRequest(SignInPayload payload) {
    return SignInRequest(login: payload.login, password: payload.password);
  }
}
