import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/login_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_login_payload.dart';

class ValidateLoginUseCase {
  Result<void> call(ValidateLoginPayload payload) {
    try {
      execute(payload);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  void execute(ValidateLoginPayload payload) {
    if (payload.login.isEmpty) {
      throw EmptyLoginException();
    }

    if (payload.login.length < 3) {
      throw TooShortLoginException();
    }
  }
}
