import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/features/auth/sign_up/domain/repositories/sign_up_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);

  final SignUpRepository _repository;

  Future<Result<void>> call(SignUpPayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> execute(SignUpPayload payload) async {
    await _repository.signUp(payload);
  }
}