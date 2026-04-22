import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/otp/domain/payloads/confirm_code_payload.dart';
import 'package:cookify/features/auth/otp/domain/repositories/otp_repository.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

class ConfirmCodeUseCase {
  ConfirmCodeUseCase(this._repository);

  final OtpRepository _repository;

  Future<Result<Token>> call(ConfirmCodePayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Token> execute(ConfirmCodePayload payload) async {
    return await _repository.confirmCode(payload);
  }
}
