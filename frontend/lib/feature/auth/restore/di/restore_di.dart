import 'package:cookify/feature/auth/restore/data/repositories_impl/restore_repository_impl.dart';
import 'package:cookify/feature/auth/restore/domain/repositories/restore_repository.dart';
import 'package:cookify/feature/auth/restore/domain/use_cases/resend_restore_use_case.dart';
import 'package:cookify/feature/auth/restore/domain/use_cases/restore_use_case.dart';
import 'package:cookify/feature/auth/restore/domain/use_cases/verify_restore_use_case.dart';
import 'package:cookify/feature/auth/restore/presentation/bloc/restore_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class RestoreDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerSingleton<RestoreRepository>(RestoreRepositoryImpl())
      ..registerSingleton(RestoreUseCase(getIt()))
      ..registerSingleton(VerifyRestoreUseCase(getIt()))
      ..registerSingleton(ResendRestoreUseCase(getIt()))
      ..registerSingleton(
        RestoreCubit(
          restoreUseCase: getIt(),
          verifyRestoreUseCase: getIt(),
          resendRestoreUseCase: getIt(),
        ),
      );
  }
}
