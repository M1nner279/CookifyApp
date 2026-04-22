import 'package:cookify/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:cookify/features/auth/sign_up/data/data_sources/sign_up_remote_data_source_impl.dart';
import 'package:cookify/features/auth/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:cookify/features/auth/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:cookify/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:cookify/features/auth/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class SignUpDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<SignUpRemoteDataSource>(
        () => SignUpRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<SignUpRepository>(
        () => SignUpRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => SignUpUseCase(getIt()))
      ..registerFactory(
        () => SignUpCubit(
          validateLoginUseCase: getIt(),
          validateEmailUseCase: getIt(),
          validatePasswordUseCase: getIt(),
          validateConfirmPasswordUseCase: getIt(),
          signUpUseCase: getIt(),
        ),
      );
  }
}
