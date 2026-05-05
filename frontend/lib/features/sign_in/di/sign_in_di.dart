import 'package:cookify/di/di.dart';
import 'package:cookify/features/sign_in/data/data_sources/sign_in_remote_data_source.dart';
import 'package:cookify/features/sign_in/data/data_sources/sign_in_remote_data_source_impl.dart';
import 'package:cookify/features/sign_in/data/repositories/sign_in_repository_impl.dart';
import 'package:cookify/features/sign_in/domain/repositories/sign_in_repository.dart';
import 'package:cookify/features/sign_in/domain/use_cases/sign_in_use_case.dart';

abstract class SignInDi {
  static SignInRemoteDataSource get _signInRemoteDataSource =>
      SignInRemoteDataSourceImpl(dio: Di.dio);

  static SignInRepository get _signInRepository =>
      SignInRepositoryImpl(remoteDataSource: _signInRemoteDataSource);

  static SignInUseCase get signInUseCase => SignInUseCase(_signInRepository);
}
