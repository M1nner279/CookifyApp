import 'package:cookify/feature/auth/change_password/di/change_password_di.dart';
import 'package:cookify/feature/auth/restore/di/restore_di.dart';
import 'package:cookify/feature/auth/sign_in/di/sign_in_di.dart';
import 'package:cookify/feature/auth/sign_up/di/sign_up_di.dart';
import 'package:get_it/get_it.dart';

abstract class AuthDi {
  static final getIt = GetIt.instance;

  static Future<void> init() async {
    await SignInDi.init();
    await SignUpDi.init();
    await RestoreDi.init();
    await ChangePasswordDi.init();
  }
}
