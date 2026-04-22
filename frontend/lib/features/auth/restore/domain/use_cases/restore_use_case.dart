import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/restore/domain/payloads/restore_payload.dart';
import 'package:cookify/features/auth/restore/domain/repositories/restore_repository.dart';

class RestoreUseCase {
  RestoreUseCase(this._repository);

  final RestoreRepository _repository;

  Future<Result<void>> call(RestorePayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> execute(RestorePayload payload) async {
    await _repository.restore(payload);
  }
}