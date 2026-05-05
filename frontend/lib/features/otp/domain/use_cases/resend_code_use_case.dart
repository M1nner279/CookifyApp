import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/otp/domain/payloads/resend_code_payload.dart';
import 'package:cookify/features/otp/domain/repositories/otp_repository.dart';

class ResendCodeUseCase {
  ResendCodeUseCase(this._repository);

  final OtpRepository _repository;

  Future<MyEither<void>> call(ResendCodePayload payload) {
    return _repository.resendCode(payload);
  }
}
