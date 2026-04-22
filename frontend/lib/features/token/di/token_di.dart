import 'package:cookify/features/token/data/data_sources/token_local_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_local_data_source_impl.dart';
import 'package:cookify/features/token/data/data_sources/token_remote_data_source.dart';
import 'package:cookify/features/token/data/data_sources/token_remote_data_source_impl.dart';
import 'package:cookify/features/token/data/repositories/token_repository_impl.dart';
import 'package:cookify/features/token/domain/repositories/token_repository.dart';
import 'package:cookify/features/token/domain/use_cases/get_token_use_case.dart';
import 'package:cookify/features/token/domain/use_cases/refresh_token_use_case.dart';
import 'package:cookify/features/token/domain/use_cases/save_token_use_case.dart';
import 'package:cookify/features/token/interceptors/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

abstract class TokenDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    getIt
      ..registerSingleton<TokenRemoteDataSource>(
        TokenRemoteDataSourceImpl(dio: getIt()),
      )
      ..registerSingleton<TokenLocalDataSource>(
        TokenLocalDataSourceImpl(storage: getIt()),
      )
      ..registerSingleton<TokenRepository>(
        TokenRepositoryImpl(
          remoteDataSource: getIt(),
          localDataSource: getIt(),
        ),
      )
      ..registerSingleton(SaveTokenUseCase(getIt()))
      ..registerSingleton(GetTokenUseCase(getIt()))
      ..registerSingleton(RefreshTokenUseCase(getIt()))
      ..registerSingleton(
        TokenInterceptor(
          getTokenUseCase: getIt(),
          refreshTokenUseCase: getIt(),
        ),
      );

    final dio = getIt<Dio>()..interceptors.add(getIt<TokenInterceptor>());
    getIt.unregister<Dio>();
    getIt.registerSingleton(dio);
  }
}
