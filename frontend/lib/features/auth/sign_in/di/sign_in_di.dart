import 'package:cookify/features/auth/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:cookify/features/auth/sign_in/data/data_sources/sign_in_remote_data_source_impl.dart';
import 'package:cookify/features/auth/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:cookify/features/auth/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:cookify/features/auth/sign_in/domain/use_cases/sign_up_use_case.dart';
import 'package:cookify/features/auth/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class SignInDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<SignInRemoteDataSource>(
        () => SignInRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<SignInRepository>(
        () => SignInRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => SignInUseCase(getIt()))
      ..registerFactory(
        () => SignInCubit(
          validateLoginUseCase: getIt(),
          validatePasswordUseCase: getIt(),
          signInUseCase: getIt(),
        ),
      );
  }
}
