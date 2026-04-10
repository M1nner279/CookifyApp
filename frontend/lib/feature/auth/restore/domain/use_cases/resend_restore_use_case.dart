import 'package:cookify/feature/auth/restore/domain/payloads/resend_restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/repositories/restore_repository.dart';

class ResendRestoreUseCase {
  ResendRestoreUseCase(this._repository);

  final RestoreRepository _repository;

  Future<void> call(ResendRestorePayload resendSignUpPayload) =>
      _repository.resendCode(resendSignUpPayload);
}
