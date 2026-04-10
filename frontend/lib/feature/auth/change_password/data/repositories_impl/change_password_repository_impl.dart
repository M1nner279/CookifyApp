import 'package:cookify/feature/auth/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/feature/auth/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  @override
  Future<bool> changePassword(ChangePasswordPayload changePasswordPayload) {
    return Future.value(true);
  }
}