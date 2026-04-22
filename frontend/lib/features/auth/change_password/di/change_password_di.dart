import 'package:cookify/features/auth/change_password/data/data_sources/change_password_remote_data_source.dart';
import 'package:cookify/features/auth/change_password/data/data_sources/change_password_remote_data_source_impl.dart';
import 'package:cookify/features/auth/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:cookify/features/auth/change_password/domain/repositories/change_password_repository.dart';
import 'package:cookify/features/auth/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:cookify/features/auth/change_password/presentation/bloc/change_password_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class ChangePasswordDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<ChangePasswordRemoteDataSource>(
        () => ChangePasswordRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<ChangePasswordRepository>(
        () => ChangePasswordRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => ChangePasswordUseCase(getIt()))
      ..registerFactory(
        () => ChangePasswordCubit(
          validatePasswordUseCase: getIt(),
          validateConfirmPasswordUseCase: getIt(),
          changePasswordUseCase: getIt(),
        ),
      );
  }
}
