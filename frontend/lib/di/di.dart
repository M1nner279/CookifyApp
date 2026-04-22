import 'package:cookify/features/auth/di/auth_di.dart';
import 'package:cookify/features/recipe/di/recipe_di.dart';
import 'package:cookify/features/token/di/token_di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class Di {
  static final getIt = GetIt.instance;

  static Future<void> init(String address) async {
    await initStorages(address);

    await TokenDi.init();
    await AuthDi.init();
    await RecipeDi.init();
  }

  static Future<void> initStorages(String address) async {
    final dio = Dio(BaseOptions(baseUrl: 'http://$address'));
    dio.interceptors.add(PrettyDioLogger());
    getIt.registerSingleton(dio);

    getIt.registerSingleton(FlutterSecureStorage());
  }
}
