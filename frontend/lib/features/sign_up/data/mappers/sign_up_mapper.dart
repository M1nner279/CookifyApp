import 'package:cookify/features/sign_up/data/requests/sign_up_request.dart';
import 'package:cookify/features/sign_up/domain/payloads/sign_up_payload.dart';

abstract class SignUpMapper {
  static SignUpRequest toRequest(SignUpPayload payload) {
    return SignUpRequest(
      login: payload.login,
      email: payload.email,
      password: payload.password,
    );
  }
}
