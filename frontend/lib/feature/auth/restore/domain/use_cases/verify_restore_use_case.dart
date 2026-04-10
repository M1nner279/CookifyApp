import 'package:cookify/feature/auth/restore/domain/payloads/verify_restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/repositories/restore_repository.dart';

class VerifyRestoreUseCase {
  VerifyRestoreUseCase(this._repository);

  final RestoreRepository _repository;

  Future<bool> call(VerifyRestorePayload verifySignUpPayload) =>
      _repository.verifyCode(verifySignUpPayload);
}
