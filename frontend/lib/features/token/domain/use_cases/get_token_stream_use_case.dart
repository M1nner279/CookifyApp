import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';
import 'package:cookify/features/token/domain/enums/token_status.dart';

final class GetTokenStreamUseCase {
  GetTokenStreamUseCase(this._repository);

  final TokenRepository _repository;

  Future<MyEither<Stream<TokenStatus>>> call() {
    return _repository.getTokenStream();
  }
}
