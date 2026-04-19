import 'package:cookify/features/auth/restore/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/auth/restore/data/data_sources/restore_remote_data_source_impl.dart';
import 'package:cookify/features/auth/restore/data/repositories/restore_repository_impl.dart';
import 'package:cookify/features/auth/restore/domain/repositories/restore_repository.dart';
import 'package:cookify/features/auth/restore/domain/use_cases/restore_use_case.dart';
import 'package:cookify/features/auth/restore/presentation/bloc/restore_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class RestoreDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerFactory<RestoreRemoteDataSource>(
        () => RestoreRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerFactory<RestoreRepository>(
        () => RestoreRepositoryImpl(remoteDataSource: getIt()),
      )
      ..registerFactory(() => RestoreUseCase(getIt()))
      ..registerFactory(
        () => RestoreCubit(
          validateLoginUseCase: getIt(),
          restoreUseCase: getIt(),
        ),
      );
  }
}
