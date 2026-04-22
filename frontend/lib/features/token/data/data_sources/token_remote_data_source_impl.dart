import 'package:cookify/features/token/data/data_sources/token_remote_data_source.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:cookify/features/token/data/requests/refresh_token_request.dart';
import 'package:dio/dio.dart';

class TokenRemoteDataSourceImpl implements TokenRemoteDataSource {
  TokenRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<TokenModel> refreshToken(RefreshTokenRequest request) async {
    final response = await _dio.post(
      '/api/auth/refresh',
      data: request.toJson(),
    );

    return TokenModel.fromJson(response.data);
  }
}
