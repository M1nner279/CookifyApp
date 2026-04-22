import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_password_payload.dart';

class ValidatePasswordUseCase {
  Result<void> call(ValidatePasswordPayload payload) {
    try {
      execute(payload);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  void execute(ValidatePasswordPayload payload) {
    if (payload.password.isEmpty) {
      throw EmptyPasswordException();
    }

    if (payload.password.length < 6) {
      throw TooShortPasswordException();
    }

    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_]).*$',
    ).hasMatch(payload.password)) {
      throw InvalidPasswordException();
    }
  }
}
