import 'package:cookify/features/auth/change_password/data/data_sources/change_password_remote_data_source.dart';
import 'package:cookify/features/auth/change_password/data/requests/change_password_request.dart';
import 'package:dio/dio.dart';

class ChangePasswordRemoteDataSourceImpl implements ChangePasswordRemoteDataSource {
  ChangePasswordRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    return;
    await _dio.post('/api/auth/sign-up', data: request.toJson());
  }
}
