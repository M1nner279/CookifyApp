import 'package:cookify/features/auth/auth_common/di/auth_common_di.dart';
import 'package:cookify/features/auth/change_password/di/change_password_di.dart';
import 'package:cookify/features/auth/otp/di/otp_di.dart';
import 'package:cookify/features/auth/restore/di/restore_di.dart';
import 'package:cookify/features/auth/sign_in/di/sign_in_di.dart';
import 'package:cookify/features/auth/sign_up/di/sign_up_di.dart';

abstract class AuthDi {
  static Future<void> init() async {
    await AuthCommonDi.init();
    await SignInDi.init();
    await SignUpDi.init();
    await RestoreDi.init();
    await OtpDi.init();
    await ChangePasswordDi.init();
  }
}
