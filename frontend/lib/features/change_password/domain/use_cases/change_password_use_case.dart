import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/features/change_password/domain/repositories/change_password_repository.dart';

final class ChangePasswordUseCase {
  ChangePasswordUseCase(this._repository);

  final ChangePasswordRepository _repository;

  Future<MyEither<void>> call(ChangePasswordPayload payload) {
    return _repository.changePassword(payload);
  }
}
