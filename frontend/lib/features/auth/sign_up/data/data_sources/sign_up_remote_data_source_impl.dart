import 'package:cookify/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:cookify/features/auth/sign_up/data/requests/sign_up_request.dart';
import 'package:dio/dio.dart';

class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  SignUpRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> signUp(SignUpRequest request) async {
    await _dio.post('/api/auth/sign-up', data: request.toJson());
  }
}
