import 'dart:convert';

import 'package:cookify/features/token/data/data_sources/token_local_data_source.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/data/requests/save_token_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  TokenLocalDataSourceImpl({required FlutterSecureStorage storage})
    : _storage = storage;

  final FlutterSecureStorage _storage;
  static const String _tokenKey = 'bearer_token';

  @override
  Future<void> saveToken(SaveTokenRequest request) async {
    await _storage.write(
      key: _tokenKey,
      value: jsonEncode(request.token.toJson()),
    );
  }

  @override
  Future<TokenModel?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    if (token == null) {
      return null;
    }

    return TokenModel.fromJson(jsonDecode(token));
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
