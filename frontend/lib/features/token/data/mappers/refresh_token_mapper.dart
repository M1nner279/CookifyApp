import 'package:cookify/features/token/data/requests/refresh_token_request.dart';
import 'package:cookify/features/token/domain/payloads/refresh_token_payload.dart';

abstract class RefreshTokenMapper {
  static RefreshTokenRequest toRequest(RefreshTokenPayload payload) {
    return RefreshTokenRequest(refreshToken: payload.refreshToken);
  }
}
