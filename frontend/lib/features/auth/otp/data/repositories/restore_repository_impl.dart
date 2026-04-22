import 'package:cookify/features/auth/otp/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/auth/otp/data/requests/confirm_code_request.dart';
import 'package:cookify/features/auth/otp/data/requests/resend_code_request.dart';
import 'package:cookify/features/auth/otp/domain/exceptions/otp_exception.dart';
import 'package:cookify/features/auth/otp/domain/payloads/confirm_code_payload.dart';
import 'package:cookify/features/auth/otp/domain/payloads/resend_code_payload.dart';
import 'package:cookify/features/auth/otp/domain/repositories/otp_repository.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:dio/dio.dart';

class OtpRepositoryImpl implements OtpRepository {
  OtpRepositoryImpl({required OtpRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final OtpRemoteDataSource _remoteDataSource;

  @override
  Future<Token> confirmCode(ConfirmCodePayload payload) async {
    try {
      final token = await _remoteDataSource.confirmCode(
        ConfirmCodeRequest(login: payload.login),
      );

      return TokenMapper.fromModel(token);
    } on DioException {
      throw IncorrectCodeException();
    }
  }

  @override
  Future<void> resendCode(ResendCodePayload payload) async {
    try {
      await _remoteDataSource.resendCode(
        ResendCodeRequest(login: payload.login),
      );
    } on DioException {}
  }
}
