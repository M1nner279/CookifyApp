import 'package:cookify/core/domain/my_either/my_either.dart';
import 'package:cookify/features/otp/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/otp/data/mappers/confirm_code_mapper.dart';
import 'package:cookify/features/otp/data/mappers/otp_failure_mapper.dart';
import 'package:cookify/features/otp/data/mappers/resend_code_mapper.dart';
import 'package:cookify/features/otp/domain/payloads/confirm_code_payload.dart';
import 'package:cookify/features/otp/domain/payloads/resend_code_payload.dart';
import 'package:cookify/features/otp/domain/repositories/otp_repository.dart';
import 'package:cookify/features/token/data/mappers/token_mapper.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:fpdart/fpdart.dart';

class OtpRepositoryImpl implements OtpRepository {
  OtpRepositoryImpl({required OtpRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final OtpRemoteDataSource _remoteDataSource;

  @override
  Future<MyEither<Token>> confirmCode(ConfirmCodePayload payload) async {
    try {
      final request = ConfirmCodeMapper.toRequest(payload);
      final tokenModel = await _remoteDataSource.confirmCode(request);

      final tokenEntity = TokenMapper.toEntity(tokenModel);

      return Right(tokenEntity);
    } on Exception catch (e) {
      return Left(OtpFailureMapper.toFailure(e));
    }
  }

  @override
  Future<MyEither<void>> resendCode(ResendCodePayload payload) async {
    try {
      final request = ResendCodeMapper.toRequest(payload);
      final result = await _remoteDataSource.resendCode(request);

      return Right(result);
    } on Exception catch (e) {
      return Left(OtpFailureMapper.toFailure(e));
    }
  }
}
