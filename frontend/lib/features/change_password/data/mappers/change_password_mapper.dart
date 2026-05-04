import 'package:cookify/features/change_password/data/requests/change_password_request.dart';
import 'package:cookify/features/change_password/domain/payloads/change_password_payload.dart';

abstract class ChangePasswordMapper {
  static ChangePasswordRequest toRequest(ChangePasswordPayload payload) {
    return ChangePasswordRequest(password: payload.password);
  }
}
