import 'package:cookify/core/domain/use_cases/results/result.dart';
import 'package:cookify/features/token/domain/entities/token.dart';
import 'package:cookify/features/token/domain/use_cases/get_token_use_case.dart';
import 'package:cookify/features/token/domain/use_cases/refresh_token_use_case.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor({
    required GetTokenUseCase getTokenUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
  }) : _getTokenUseCase = getTokenUseCase,
       _refreshTokenUseCase = refreshTokenUseCase;

  final GetTokenUseCase _getTokenUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await _getTokenUseCase();
    if (result is Success<Token?>) {
      if (result.data != null) {
        options.headers['Authorization'] = 'Bearer ${result.data}';
      }
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _refreshTokenUseCase();
    }
    handler.next(err);
  }
}
