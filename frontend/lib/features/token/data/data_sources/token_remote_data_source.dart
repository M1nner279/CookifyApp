import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/data/requests/refresh_token_request.dart';

abstract interface class TokenRemoteDataSource {
  Future<TokenModel> refreshToken(RefreshTokenRequest request);
}
