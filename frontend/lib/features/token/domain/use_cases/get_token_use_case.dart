import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';

final class GetTokenUseCase {
  GetTokenUseCase(this._repository);

  final TokenRepository _repository;

  Future<MyEither<Token?>> call() {
    return _repository.getToken();
  }
}
