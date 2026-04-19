import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/change_password/domain/payloads/change_password_payload.dart';
import 'package:cookify/features/auth/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordUseCase {
  ChangePasswordUseCase(this._repository);

  final ChangePasswordRepository _repository;

  Future<Result<void>> call(ChangePasswordPayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> execute(ChangePasswordPayload payload) async {
    await _repository.changePassword(payload);
  }
}
