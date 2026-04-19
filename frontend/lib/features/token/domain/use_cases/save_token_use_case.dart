import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/token/domain/payloads/save_token_payload.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';

class SaveTokenUseCase {
  SaveTokenUseCase(this._repository);

  final TokenRepository _repository;

  Future<Result<void>> call(SaveTokenPayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> execute(SaveTokenPayload payload) async {
    await _repository.saveToken(payload);
  }
}
