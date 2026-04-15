import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/auth/sign_in/domain/repositories/sign_in_repository.dart';

class SignInUseCase {
  SignInUseCase(this._repository);

  final SignInRepository _repository;

  Future<Result<void>> call(SignInPayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<void> execute(SignInPayload payload) async {
    await _repository.signIn(payload);
  }
}