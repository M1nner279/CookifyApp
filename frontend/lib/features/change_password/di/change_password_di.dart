import 'package:cookify/di/di.dart';
import 'package:cookify/features/change_password/data/data_sources/change_password_remote_data_source.dart';
import 'package:cookify/features/change_password/data/data_sources/change_password_remote_data_source_impl.dart';
import 'package:cookify/features/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:cookify/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:cookify/features/change_password/domain/use_cases/change_password_use_case.dart';

abstract class ChangePasswordDi {
  static ChangePasswordRemoteDataSource get _changePasswordRemoteDataSource =>
      ChangePasswordRemoteDataSourceImpl(dio: Di.dio);

  static ChangePasswordRepository get _changePasswordRepository =>
      ChangePasswordRepositoryImpl(
        remoteDataSource: _changePasswordRemoteDataSource,
      );

  static ChangePasswordUseCase get changePasswordUseCase =>
      ChangePasswordUseCase(_changePasswordRepository);
}
