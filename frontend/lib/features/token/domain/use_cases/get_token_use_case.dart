import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';

class GetTokenUseCase {
  GetTokenUseCase(this._repository);

  final TokenRepository _repository;

  Future<Result<Token?>> call() async {
    try {
      return Result.success(await execute());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Token?> execute() async {
    return await _repository.getToken();
  }
}
