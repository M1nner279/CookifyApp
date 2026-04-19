import 'package:cookify/features/auth/otp/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/auth/otp/data/data_sources/restore_remote_data_source_impl.dart';
import 'package:cookify/features/auth/otp/data/repositories/restore_repository_impl.dart';
import 'package:cookify/features/auth/otp/domain/repositories/otp_repository.dart';
import 'package:cookify/features/auth/otp/domain/use_cases/confirm_code_use_case.dart';
import 'package:cookify/features/auth/otp/domain/use_cases/resend_code_use_case.dart';
import 'package:cookify/features/auth/otp/presentation/bloc/otp_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class OtpDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<OtpRemoteDataSource>(
        () => OtpRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<OtpRepository>(
        () => OtpRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => ConfirmCodeUseCase(getIt()))
      ..registerFactory(() => ResendCodeUseCase(getIt()))
      ..registerFactoryParam<OtpCubit, String, void>(
        (login, _) => OtpCubit(
          login: login,
          confirmCodeUseCase: getIt(),
          resendCodeUseCase: getIt(),
          saveTokenUseCase: getIt(),
        ),
      );
  }
}
