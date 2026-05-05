import 'package:cookify/features/sign_up/data/consts/sign_up_end_points.dart';
import 'package:cookify/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:cookify/features/sign_up/data/exceptions/sign_in_exceptions.dart';
import 'package:cookify/features/sign_up/data/requests/sign_up_request.dart';
import 'package:dio/dio.dart';

final class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  SignUpRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<void> signUp(SignUpRequest request) async {
    try {
      await _dio.post(signUpEndPoint, data: request.toJson());
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final a = e.response!.data.first['code'] as String;
        if (a == 'DuplicateUserName') {
          throw LoginAlreadyExistsException();
        }
        else {
          throw EmailAlreadyExistsException();
        }
      }
      rethrow;
    }
  }
}
