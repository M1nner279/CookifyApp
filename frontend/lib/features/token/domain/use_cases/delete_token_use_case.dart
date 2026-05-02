import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';

final class DeleteTokenUseCase {
  DeleteTokenUseCase(this._repository);

  final TokenRepository _repository;

  Future<MyEither<void>> call() {
    return _repository.deleteToken();
  }
}
