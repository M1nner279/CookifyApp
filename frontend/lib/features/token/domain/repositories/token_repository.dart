import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/payloads/refresh_token_payload.dart';
import 'package:cookify/features/token/domain/payloads/set_token_payload.dart';
import 'package:cookify/features/token/domain/enums/token_status.dart';

abstract interface class TokenRepository {
  Future<MyEither<Token?>> getToken();

  Future<MyEither<void>> setToken(SetTokenPayload payload);

  Future<MyEither<Token>> refreshToken(RefreshTokenPayload payload);

  Future<MyEither<void>> deleteToken();

  Future<MyEither<Stream<TokenStatus>>> getTokenStream();

  Future<MyEither<void>> markTokenAsInvalid();
}
