import 'package:cookify/core/data/exceptions/exceptions.dart';
import 'package:cookify/dependencies/change_password_dependency_impl.dart';
import 'package:cookify/dependencies/profile_dependency_impl.dart';
import 'package:cookify/dependencies/restore_dependency_impl.dart';
import 'package:cookify/dependencies/sign_in_dependency_impl.dart';
import 'package:cookify/dependencies/sign_up_dependency_impl.dart';
import 'package:cookify/features/restore/dependencies/restore_dependency.dart';
import 'package:cookify/features/sign_in/dependecies/sign_in_dependency.dart';
import 'package:cookify/features/change_password/dependencies/change_password_dependency.dart';
import 'package:cookify/features/credentials_validation/di/credentials_validation_di.dart';
import 'package:cookify/features/locale/di/locale_di.dart';
import 'package:cookify/features/profile/dependencies/profile_dependency.dart';
import 'package:cookify/features/recipe/di/recipe_di.dart';
import 'package:cookify/features/sign_up/dependencies/sign_up_dependency.dart';
import 'package:cookify/features/token/di/token_di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Di {
  static final getIt = GetIt.instance;

  static Future<void> init(String address) async {
    getIt.registerSingleton(secureStorage);

    await initStorages(address);

    await RecipeDi.init();
  }

  static Future<void> initStorages(String address) async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://$address',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );
    Di.dio = dio;
    dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(FailureInterceptor());
    getIt.registerSingleton(dio);
    dio.interceptors.add(TokenDi.tokenInterceptor);
  }

  static late Dio dio;

  static final SharedPreferencesAsync sharedPreferences =
      SharedPreferencesAsync();

  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  static SignInDependency get signInDependency => SignInDependencyImpl(
    validatePasswordUseCase: CredentialsValidationDi.validatePasswordUseCase,
    validateLoginUseCase: CredentialsValidationDi.validateLoginUseCase,
    setTokenUseCase: TokenDi.setTokenUseCase,
  );

  static SignUpDependency get signUpDependency => SignUpDependencyImpl(
    validateLoginUseCase: CredentialsValidationDi.validateLoginUseCase,
    validateEmailUseCase: CredentialsValidationDi.validateEmailUseCase,
    validatePasswordUseCase: CredentialsValidationDi.validatePasswordUseCase,
    validateConfirmPasswordUseCase:
        CredentialsValidationDi.validateConfirmPasswordUseCase,
  );

  static RestoreDependency get restoreDependency => RestoreDependencyImpl(
    validateLoginUseCase: CredentialsValidationDi.validateLoginUseCase,
    validateEmailUseCase: CredentialsValidationDi.validateEmailUseCase,
  );

  static ChangePasswordDependency get changePasswordDependency =>
      ChangePasswordDependencyImpl(
        validatePasswordUseCase:
            CredentialsValidationDi.validatePasswordUseCase,
        validateConfirmPasswordUseCase:
            CredentialsValidationDi.validateConfirmPasswordUseCase,
      );

  static ProfileDependency get profileDependency => ProfileDependencyImpl(
    getLocaleUseCase: LocaleDi.getLocaleUseCase,
    setLocaleUseCase: LocaleDi.setLocaleUseCase,
    deleteTokenUseCase: TokenDi.deleteTokenUseCase,
  );
}

class FailureInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      // Создаем кастомную ошибку, сохраняя контекст запроса
      throw NetworkException();
    }

    // Если это не ошибка сети, пропускаем ошибку дальше
    return handler.next(err);
  }
}
