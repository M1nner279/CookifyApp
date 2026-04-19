import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/auth/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/auth/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:cookify/features/token/domain/entities/token.dart';

class SignInUseCase {
  SignInUseCase(this._repository);

  final SignInRepository _repository;

  Future<Result<Token>> call(SignInPayload payload) async {
    try {
      return Result.success(await execute(payload));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  Future<Token> execute(SignInPayload payload) async {
    return await _repository.signIn(payload);
  }
}