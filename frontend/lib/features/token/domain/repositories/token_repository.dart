import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/payloads/refresh_token_payload.dart';
import 'package:cookify/features/token/domain/payloads/save_token_payload.dart';

abstract interface class TokenRepository {
  Future<void> saveToken(SaveTokenPayload payload);

  Future<Token?> getToken();

  Future<Token> refreshToken(RefreshTokenPayload payload);

  Future<void> deleteToken();
}
