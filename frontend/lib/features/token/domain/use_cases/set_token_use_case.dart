import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/token/domain/payloads/set_token_payload.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';

class SetTokenUseCase {
  SetTokenUseCase(this._repository);

  final TokenRepository _repository;

  Future<MyEither<void>> call(SetTokenPayload payload) {
    return _repository.setToken(payload);
  }
}
