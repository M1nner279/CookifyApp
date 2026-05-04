import 'package:cookify/features/restore/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/restore/data/exceptions/restore_exceptions.dart';
import 'package:cookify/features/restore/data/requests/restore_request.dart';
import 'package:dio/dio.dart';

class RestoreRemoteDataSourceImpl implements RestoreRemoteDataSource {
  RestoreRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> restore(RestoreRequest request) async {
    try {
      await _dio.post('/api/auth/restore', data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw NonExistentLoginOrEmailException();
      }
    }
  }
}
