import 'package:cookify/di/di.dart';
import 'package:cookify/features/otp/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/otp/data/data_sources/restore_remote_data_source_impl.dart';
import 'package:cookify/features/otp/data/repositories/otp_repository_impl.dart';
import 'package:cookify/features/otp/domain/repositories/otp_repository.dart';
import 'package:cookify/features/otp/domain/use_cases/confirm_code_use_case.dart';
import 'package:cookify/features/otp/domain/use_cases/resend_code_use_case.dart';

abstract class OtpDi {
  static OtpRemoteDataSource get _otpRemoteDataSource =>
      OtpRemoteDataSourceImpl(dio: Di.dio);

  static OtpRepository get _otpRepository =>
      OtpRepositoryImpl(remoteDataSource: _otpRemoteDataSource);

  static ConfirmCodeUseCase get confirmCodeUseCase =>
      ConfirmCodeUseCase(_otpRepository);

  static ResendCodeUseCase get resendCodeUseCase =>
      ResendCodeUseCase(_otpRepository);
}
