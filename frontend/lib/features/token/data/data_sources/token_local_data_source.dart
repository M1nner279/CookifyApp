import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/data/requests/set_token_request.dart';

abstract interface class TokenLocalDataSource {
  Future<TokenModel?> getToken();

  Future<void> setToken(SetTokenRequest request);

  Future<void> deleteToken();
}
