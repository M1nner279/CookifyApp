import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/otp/domain/payloads/resend_code_payload.dart';
import 'package:cookify/features/auth/otp/domain/repositories/otp_repository.dart';

class ResendCodeUseCase {
  ResendCodeUseCase(this._repository);

  final OtpRepository _repository;

  Future<Result<void>> call(ResendCodePayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> execute(ResendCodePayload payload) async {
    await _repository.resendCode(payload);
  }
}
