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
  // 1. Проверяем, что ошибка — 401 и у нас есть данные запроса
  if (err.response?.statusCode == 401) {
    // 2. Пытаемся обновить токен
    final refreshResult = await _refreshTokenUseCase();
    
    return refreshResult.fold(
      (failure) => handler.next(err), // Если рефреш не удался — пробрасываем ошибку дальше
      (newToken) async {
        try {
          // 3. Создаем дубликат запроса с новым токеном
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer ${newToken.accessToken}';

          // 4. Повторяем запрос через новый инстанс или тот же dio
          // Важно: создайте новый запрос через новый экземпляр Dio, 
          // чтобы избежать зацикливания или используйте текущий
          final dio = Dio(); 
          final response = await dio.fetch(options);

          // 5. Возвращаем успешный ответ в основной поток
          return handler.resolve(response);
        } on DioException catch (e) {
          return handler.next(e);
        }
      },
    );
  }
  
  handler.next(err);
}

}
