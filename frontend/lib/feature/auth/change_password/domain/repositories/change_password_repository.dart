import 'package:cookify/feature/auth/change_password/domain/payloads/change_password_payload.dart';

abstract interface class ChangePasswordRepository {
  Future<bool> changePassword(ChangePasswordPayload changePasswordPayload);
}