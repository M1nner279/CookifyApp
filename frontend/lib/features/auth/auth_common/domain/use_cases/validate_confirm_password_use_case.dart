import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/auth_common/domain/exceptions/confirm_password_exception.dart';
import 'package:cookify/features/auth/auth_common/domain/payloads/validate_confirm_password_payload.dart';

class ValidateConfirmPasswordUseCase {
  Result<void> call(ValidateConfirmPasswordPayload payload) {
    try {
      execute(payload);
      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  void execute(ValidateConfirmPasswordPayload payload) {
    if (payload.confirmPassword.isEmpty) {
      throw EmptyConfirmPasswordException();
    }

    if (payload.password != payload.confirmPassword) {
      throw NotMatchConfirmPasswordException();
    }
  }
}
