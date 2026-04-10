import 'package:cookify/feature/auth/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/feature/auth/restore/domain/repositories/restore_repository.dart';

class RestoreUseCase {
  RestoreUseCase(this._repository);

  final RestoreRepository _repository;

  Future<bool> call(RestorePayload restorePayload) {
    return _repository.restore(restorePayload);
  }
}
