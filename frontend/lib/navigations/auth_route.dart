import 'package:cookify/features/auth/auth_common/presentation/pages/auth_page.dart';
import 'package:cookify/features/auth/change_password/presentation/pages/change_password_page.dart';
import 'package:cookify/features/auth/otp/presentation/pages/otp_page.dart';
import 'package:cookify/features/auth/otp/presentation/pages/otp_page_args.dart';
import 'package:go_router/go_router.dart';

final authRoute = [
  GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),

  GoRoute(
    path: '/otp',
    builder: (context, state) {
      final args = state.extra as OtpPageArgs;

      return OtpPage(args: args);
    },
  ),

  GoRoute(
    path: '/change-password',
    builder: (context, state) => const ChangePasswordPage(),
  ),
];
