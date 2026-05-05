import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/otp/domain/payloads/confirm_code_payload.dart';
import 'package:cookify/features/otp/domain/repositories/otp_repository.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

class ConfirmCodeUseCase {
  ConfirmCodeUseCase(this._repository);

  final OtpRepository _repository;

  Future<MyEither<Token>> call(ConfirmCodePayload payload) {
    return _repository.confirmCode(payload);
  }
}
