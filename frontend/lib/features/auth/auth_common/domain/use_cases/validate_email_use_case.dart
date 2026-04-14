import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/email_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_email_payload.dart';

class ValidateEmailUseCase {
  Result<void> call(ValidateEmailPayload payload) {
    try {
      execute(payload);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  void execute(ValidateEmailPayload payload) {
    if (payload.email.isEmpty) {
      throw EmptyEmailException();
    }

    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(payload.email)) {
      throw InvalidEmailException();
    }
  }
}
