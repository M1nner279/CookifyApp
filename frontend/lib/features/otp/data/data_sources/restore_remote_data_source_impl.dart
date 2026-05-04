import 'package:cookify/features/otp/data/consts/otp_end_point.dart';
import 'package:cookify/features/otp/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/otp/data/exceptions/otp_exceptions.dart';
import 'package:cookify/features/otp/data/requests/confirm_code_request.dart';
import 'package:cookify/features/otp/data/requests/resend_code_request.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:dio/dio.dart';

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  OtpRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<TokenModel> confirmCode(ConfirmCodeRequest request) async {
    try {
      final response = await _dio.post(
        confirmCodeEndPoint,
        data: request.toJson(),
      );

      return TokenModel.fromJson(response.data);
    } on DioException {
      throw InvalidCodeException();
    }
  }

  @override
  Future<void> resendCode(ResendCodeRequest request) async {
    await _dio.post(resendCodeEndPoint, data: request.toJson());
  }
}
