import 'package:cookify/features/otp/data/requests/resend_code_request.dart';
import 'package:cookify/features/otp/domain/payloads/resend_code_payload.dart';

abstract class ResendCodeMapper {
  static ResendCodeRequest toRequest(ResendCodePayload payload) {
    return ResendCodeRequest(login: payload.login);
  }
}
