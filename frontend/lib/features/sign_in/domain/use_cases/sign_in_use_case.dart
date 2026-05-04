import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

class SignInUseCase {
  SignInUseCase(this._repository);

  final SignInRepository _repository;

  Future<MyEither<Token>> call(SignInPayload payload) {
    return _repository.signIn(payload);
  }
}
