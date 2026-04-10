import 'package:cookify/feature/auth/sign_up/domain/payloads/resend_sign_up_payload.dart';
import 'package:cookify/feature/auth/sign_up/domain/repositories/sign_up_repository.dart';

class ResendSignUpUseCase {
  ResendSignUpUseCase(this._repository);

  final SignUpRepository _repository;

  Future<void> call(ResendSignUpPayload resendSignUpPayload) =>
      _repository.resendCode(resendSignUpPayload);
}
