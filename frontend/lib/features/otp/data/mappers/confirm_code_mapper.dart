import 'package:cookify/features/otp/data/requests/confirm_code_request.dart';
import 'package:cookify/features/otp/domain/payloads/confirm_code_payload.dart';

abstract class ConfirmCodeMapper {
  static ConfirmCodeRequest toRequest(ConfirmCodePayload payload) {
    return ConfirmCodeRequest(login: payload.login, code: payload.code);
  }
}
