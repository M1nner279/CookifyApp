import 'package:cookify/features/auth/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:cookify/features/auth/sign_in/data/requests/sign_in_request.dart';
import 'package:dio/dio.dart';

class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  SignInRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> signIn(SignInRequest request) async {
    await _dio.post('/api/auth/sign-in', data: request.toJson());
  }
}
