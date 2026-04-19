import 'package:cookify/features/token/data/data_sources/token_local_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_remote_data_source.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/data/requests/refresh_token_request.dart';
import 'package:cookify/features/token/data/requests/save_token_request.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/exceptions/token_exception.dart';
import 'package:cookify/features/token/domain/payloads/refresh_token_payload.dart';
import 'package:cookify/features/token/domain/payloads/save_token_payload.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';
import 'package:dio/dio.dart';

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl({
    required TokenRemoteDataSource remoteDataSource,
    required TokenLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final TokenRemoteDataSource _remoteDataSource;
  final TokenLocalDataSource _localDataSource;

  @override
  Future<void> saveToken(SaveTokenPayload payload) async {
    await _localDataSource.saveToken(
      SaveTokenRequest(token: TokenMapper.toModel(payload.token)),
    );
  }

  @override
  Future<Token?> getToken() async {
    final token = await _localDataSource.getToken();

    return token == null ? null : TokenMapper.fromModel(token);
  }

  @override
  Future<Token> refreshToken(RefreshTokenPayload payload) async {
    try {
      final token = await _remoteDataSource.refreshToken(
        RefreshTokenRequest(refreshToken: payload.refreshToken),
      );

      return TokenMapper.fromModel(token);
    } on DioException {
      throw ExpiredRefreshTokenException();
    }
  }

  @override
  Future<void> deleteToken() async {
    await _localDataSource.deleteToken();
  }
}
