import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/data/requests/save_token_request.dart';

abstract interface class TokenLocalDataSource {
  Future<void> saveToken(SaveTokenRequest request);

  Future<TokenModel?> getToken();

  Future<void> deleteToken();
}
