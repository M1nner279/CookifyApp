import 'package:cookify/di/di.dart';
import 'package:cookify/features/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:cookify/features/sign_up/data/data_sources/sign_up_remote_data_source_impl.dart';
import 'package:cookify/features/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:cookify/features/sign_up/domain/repositories/sign_up_repository.dart';
import 'package:cookify/features/sign_up/domain/use_cases/sign_up_use_case.dart';

abstract class SignUpDi {
  static SignUpRemoteDataSource get _signUpRemoteDataSource =>
      SignUpRemoteDataSourceImpl(dio: Di.dio);

  static SignUpRepository get _signUpRepository =>
      SignUpRepositoryImpl(remoteDataSource: _signUpRemoteDataSource);

  static SignUpUseCase get signUpUseCase => SignUpUseCase(_signUpRepository);
}
