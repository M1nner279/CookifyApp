import 'package:cookify/feature/auth/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/feature/auth/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordUseCase {
  ChangePasswordUseCase(this._repository);

  final ChangePasswordRepository _repository;

  Future<bool> call(ChangePasswordPayload payload) {
    return _repository.changePassword(payload);
  }
}