import 'package:cookify/features/auth/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:cookify/features/auth/sign_in/data/requests/sign_in_request.dart';
import 'package:cookify/features/auth/sign_in/domain/exceptions/sign_in_exception.dart';
import 'package:cookify/features/auth/sign_in/domain/payloads/sign_in_payload.dart';
import 'package:cookify/features/auth/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:dio/dio.dart';

class SignInRepositoryImpl implements SignInRepository {
  SignInRepositoryImpl({required SignInRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final SignInRemoteDataSource _remoteDataSource;

  @override
  Future<Token> signIn(SignInPayload payload) async {
    try {
      final token = await _remoteDataSource.signIn(
        SignInRequest(login: payload.login, password: payload.password),
      );

      return TokenMapper.fromModel(token);
    } on DioException {
      throw IncorrectLoginOrPasswordException();
    }
  }
}
