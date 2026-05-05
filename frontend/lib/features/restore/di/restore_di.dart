import 'package:cookify/di/di.dart';
import 'package:cookify/features/restore/data/data_sources/restore_remote_data_source.dart';
import 'package:cookify/features/restore/data/data_sources/restore_remote_data_source_impl.dart';
import 'package:cookify/features/restore/data/repositories/restore_repository_impl.dart';
import 'package:cookify/features/restore/domain/repositories/restore_repository.dart';
import 'package:cookify/features/restore/domain/use_cases/restore_use_case.dart';

abstract class RestoreDi {
  static RestoreRemoteDataSource get _restoreRemoteDataSource =>
      RestoreRemoteDataSourceImpl(dio: Di.dio);

  static RestoreRepository get _restoreRepository =>
      RestoreRepositoryImpl(remoteDataSource: _restoreRemoteDataSource);

  static RestoreUseCase get restoreUseCase => RestoreUseCase(_restoreRepository);
}
