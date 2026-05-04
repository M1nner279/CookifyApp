import 'package:cookify/features/change_password/data/consts/change_password_end_points.dart';
import 'package:cookify/features/change_password/data/data_sources/change_password_remote_data_source.dart';
import 'package:cookify/features/change_password/data/requests/change_password_request.dart';
import 'package:dio/dio.dart';

final class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSource {
  ChangePasswordRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    await _dio.post(changePasswordEndPoint, data: request.toJson());
  }
}
