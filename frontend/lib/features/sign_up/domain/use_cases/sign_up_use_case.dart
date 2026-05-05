import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/features/sign_up/domain/repositories/sign_up_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);

  final SignUpRepository _repository;

  Future<MyEither<void>> call(SignUpPayload payload) {
    return _repository.signUp(payload);
  }
}
