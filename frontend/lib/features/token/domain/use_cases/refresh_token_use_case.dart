import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/token/domain/payloads/refresh_token_payload.dart';
import 'package:cookify/features/token/domain/payloads/save_token_payload.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';

class RefreshTokenUseCase {
  RefreshTokenUseCase(this._repository);

  final TokenRepository _repository;

  Future<Result<void>> call() async {
    try {
      return Result.success(await execute());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> execute() async {
    final token = (await _repository.getToken())!;

    try {
      final newToken = await _repository.refreshToken(
        RefreshTokenPayload(refreshToken: token.refreshToken),
      );

      await _repository.saveToken(SaveTokenPayload(token: newToken));
    } on Exception {
      await _repository.deleteToken();
      rethrow;
    }
  }
}
