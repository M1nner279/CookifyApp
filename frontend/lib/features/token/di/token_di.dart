import 'package:cookify/di/di.dart';
import 'package:cookify/features/token/data/data_sources/token_local_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_local_data_source_impl.dart';
import 'package:cookify/features/token/data/data_sources/token_remote_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_remote_data_source_impl.dart';
import 'package:cookify/features/token/data/data_sources/token_stream_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_stream_data_source_impl.dart';
import 'package:cookify/features/token/data/repositories/token_repository_impl.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';
import 'package:cookify/features/token/domain/use_cases/delete_token_use_case.dart';
import 'package:cookify/features/token/domain/use_cases/get_token_stream_use_case.dart';
import 'package:cookify/features/token/domain/use_cases/get_token_use_case.dart';
import 'package:cookify/features/token/domain/use_cases/refresh_token_use_case.dart';
import 'package:cookify/features/token/domain/use_cases/set_token_use_case.dart';
import 'package:cookify/features/token/interceptors/token_interceptor.dart';

abstract class TokenDi {
  static TokenRemoteDataSource get _tokenRemoteDataSource =>
      TokenRemoteDataSourceImpl(dio: Di.dio);

  static TokenLocalDataSource get _tokenLocalDataSource =>
      TokenLocalDataSourceImpl(storage: Di.secureStorage);

  static TokenStreamDataSource get _tokenStreamDataSource =>
      TokenStreamDataSourceImpl();

  static TokenRepository get _tokenRepository => TokenRepositoryImpl(
    remoteDataSource: _tokenRemoteDataSource,
    localDataSource: _tokenLocalDataSource,
    streamDataSource: _tokenStreamDataSource,
  );

  static GetTokenUseCase get getTokenUseCase =>
      GetTokenUseCase(_tokenRepository);

  static SetTokenUseCase get setTokenUseCase =>
      SetTokenUseCase(_tokenRepository);

  static RefreshTokenUseCase get refreshTokenUseCase =>
      RefreshTokenUseCase(_tokenRepository);

  static DeleteTokenUseCase get deleteTokenUseCase =>
      DeleteTokenUseCase(_tokenRepository);

  static GetTokenStreamUseCase get getTokenStreamUseCase =>
      GetTokenStreamUseCase(_tokenRepository);

  static TokenInterceptor get tokenInterceptor => TokenInterceptor(
    getTokenUseCase: getTokenUseCase,
    refreshTokenUseCase: refreshTokenUseCase,
  );
}
