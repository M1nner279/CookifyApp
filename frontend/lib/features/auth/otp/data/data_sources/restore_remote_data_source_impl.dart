import 'package:cookify/features/auth/otp/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/auth/otp/data/requests/confirm_code_request.dart';
import 'package:cookify/features/auth/otp/data/requests/resend_code_request.dart';
import 'package:cookify/features/token/data/models/token_model.dart';
import 'package:dio/dio.dart';

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  OtpRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<TokenModel> confirmCode(ConfirmCodeRequest request) async {
    return TokenModel(accessToken: '', refreshToken: '');
    await _dio.post('/api/auth/restore', data: request.toJson());
  }

  @override
  Future<void> resendCode(ResendCodeRequest request) async {
    return;
    await _dio.post('/api/auth/restore', data: request.toJson());
  }
}
