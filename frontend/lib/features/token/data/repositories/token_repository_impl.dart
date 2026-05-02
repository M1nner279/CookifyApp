import 'package:cookify/core/data/mappers/failure_mapper.dart';
import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/token/data/data_sources/token_local_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_remote_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_stream_data_source.dart';
import 'package:cookify/features/token/data/mappers/refresh_token_mapper.dart';
import 'package:cookify/features/token/data/mappers/set_token_mapper.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/payloads/refresh_token_payload.dart';
import 'package:cookify/features/token/domain/payloads/set_token_payload.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';
import 'package:cookify/features/token/domain/enums/token_status.dart';
import 'package:fpdart/fpdart.dart';

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl({
    required TokenRemoteDataSource remoteDataSource,
    required TokenLocalDataSource localDataSource,
    required TokenStreamDataSource streamDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _streamDataSource = streamDataSource;

  final TokenRemoteDataSource _remoteDataSource;
  final TokenLocalDataSource _localDataSource;
  final TokenStreamDataSource _streamDataSource;

  @override
  Future<MyEither<Token?>> getToken() async {
    try {
      final tokenModel = await _localDataSource.getToken();

      if (tokenModel == null) {
        return Right(null);
      }
      final tokenEntity = TokenMapper.toEntity(tokenModel);

      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<void>> setToken(SetTokenPayload payload) async {
    try {
      final request = SetTokenMapper.toRequest(payload);
      final result = await _localDataSource.setToken(request);

      return Right(result);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<Token>> refreshToken(RefreshTokenPayload payload) async {
    try {
      final request = RefreshTokenMapper.toRequest(payload);
      final tokenModel = await _remoteDataSource.refreshToken(request);

      final tokenEntity = TokenMapper.toEntity(tokenModel);

      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<void>> deleteToken() async {
    try {
      final result = await _localDataSource.deleteToken();

      return Right(result);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<Stream<TokenStatus>>> getTokenStream() async {
    try {
      final stream = await _streamDataSource.getTokenStream();

      return Right(stream);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<void>> markTokenAsInvalid() async {
    try {
      final result = await _streamDataSource.markTokenAsInvalid();

      return Right(result);
    } on Exception catch (e) {
      return Left(FailureMapper.toFailure(e));
    }
  }
}
