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
    result.fold((_) {}, (token) {
      if (token != null) {
        options.headers['Authorization'] = 'Bearer ${token.accessToken}';
      }
    });
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
