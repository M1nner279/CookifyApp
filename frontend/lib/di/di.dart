import 'package:cookify/feature/profile/di/profile_di.dart';
import 'package:get_it/get_it.dart';

abstract class Di {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    await ProfileDi.init();
  }
}