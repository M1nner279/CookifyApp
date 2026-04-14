import 'package:cookify/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:cookify/features/auth/sign_up/data/requests/sign_up_request.dart';
import 'package:cookify/features/auth/sign_up/domain/exceptions/sign_up_exception.dart';
import 'package:cookify/features/auth/sign_up/domain/payloads/sign_up_payload.dart';
import 'package:cookify/features/auth/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:dio/dio.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  SignUpRepositoryImpl({required SignUpRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final SignUpRemoteDataSource _remoteDataSource;

  @override
  Future<void> signUp(SignUpPayload payload) async {
    try {
      await _remoteDataSource.signUp(
        SignUpRequest(
          login: payload.login,
          email: payload.email,
          password: payload.password,
        ),
      );
    } on DioException catch (e) {
      if ((e.message ?? '').contains('login') &&
          (e.message ?? '').contains('email')) {
        throw LoginAndEmailAlreadyExistsException();
      } else if ((e.message ?? '').contains('login')) {
        throw LoginAlreadyExistsException();
      } else if ((e.message ?? '').contains('email')) {
        throw EmailAlreadyExistsException();
      }
    }
  }
}
