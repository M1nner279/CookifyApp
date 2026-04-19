import 'package:cookify/features/auth/change_password/domain/payloads/change_password_payload.dart';

abstract interface class ChangePasswordRepository {
  Future<void> changePassword(ChangePasswordPayload payload);
}
