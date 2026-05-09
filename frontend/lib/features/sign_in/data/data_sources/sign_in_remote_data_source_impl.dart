import 'package:cookify/core/data/exceptions/exceptions.dart';
import 'package:cookify/features/sign_in/data/consts/sign_in_end_points.dart';
import 'package:cookify/features/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:cookify/features/sign_in/data/exceptions/sign_in_exceptions.dart';
import 'package:cookify/features/sign_in/data/requests/sign_in_request.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:dio/dio.dart';

final class SignInRemoteDataSourceImpl implements SignInRemoteDataSource {
  SignInRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<TokenModel> signIn(SignInRequest request) async {
    try {
      final response = await _dio.post(signInEndpoint, data: request.toJson());

      return TokenModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.error is NetworkException) {
      throw e.error as NetworkException;
    }
      if (e.response?.statusCode == 401) {
        throw IncorrectLoginOrPasswordException();
      }
      rethrow;
    }
  }
}
