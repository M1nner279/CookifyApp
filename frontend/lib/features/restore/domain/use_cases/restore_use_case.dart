import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/features/restore/domain/repositories/restore_repository.dart';

class RestoreUseCase {
  RestoreUseCase(this._repository);

  final RestoreRepository _repository;

  Future<MyEither<void>> call(RestorePayload payload) {
    return _repository.restore(payload);
  }
}
