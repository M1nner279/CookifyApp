import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/token/domain/failures/token_failures.dart';
import 'package:cookify/features/token/domain/payloads/refresh_token_payload.dart';
import 'package:cookify/features/token/domain/payloads/set_token_payload.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';
import 'package:fpdart/fpdart.dart';

class RefreshTokenUseCase {
  RefreshTokenUseCase(this._repository);

  final TokenRepository _repository;

  Future<MyEither<void>> call() async {
    final tokenResult = await _repository.getToken();

    return tokenResult.fold((failure) => Left(failure), (token) async {
      if (token == null) {
        return const Left(NotFoundTokenFailure());
      }

      final newTokenResult = await _repository.refreshToken(
        RefreshTokenPayload(refreshToken: token.refreshToken),
      );

      return newTokenResult.fold(
        (failure) async {
          await _repository.markTokenAsInvalid();
          await _repository.deleteToken();

          return Left(failure);
        },
        (newToken) {
          return _repository.setToken(SetTokenPayload(token: newToken));
        },
      );
    });
  }
}
