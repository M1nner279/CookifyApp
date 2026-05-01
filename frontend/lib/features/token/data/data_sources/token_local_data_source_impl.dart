import 'dart:convert';

import 'package:cookify/features/token/data/consts/token_keys.dart';
import 'package:cookify/features/token/data/data_sources/token_local_data_source.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/data/requests/set_token_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  TokenLocalDataSourceImpl({required FlutterSecureStorage storage})
    : _storage = storage;

  final FlutterSecureStorage _storage;

  @override
  Future<TokenModel?> getToken() async {
    final token = await _storage.read(key: tokenKey);
    if (token == null) {
      return null;
    }

    return TokenModel.fromJson(jsonDecode(token));
  }

  @override
  Future<void> setToken(SetTokenRequest request) {
    return _storage.write(
      key: tokenKey,
      value: jsonEncode(request.token.toJson()),
    );
  }

  @override
  Future<void> deleteToken() {
    return _storage.delete(key: tokenKey);
  }
}
