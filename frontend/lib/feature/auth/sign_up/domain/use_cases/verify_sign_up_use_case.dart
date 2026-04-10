import 'package:cookify/feature/auth/sign_up/domain/payloads/verify_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/repositories/sign_up_repository.dart';

class VerifySignUpUseCase {
  VerifySignUpUseCase(this._repository);

  final SignUpRepository _repository;

  Future<bool> call(VerifySignUpPayload verifySignUpPayload) =>
      _repository.verifyCode(verifySignUpPayload);
}
