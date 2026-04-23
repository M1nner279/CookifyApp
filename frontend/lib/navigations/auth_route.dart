import 'package:cookify/features/auth/auth_common/presentation/pages/auth_page.dart';
import 'package:cookify/features/auth/change_password/presentation/pages/change_password_page.dart';
import 'package:cookify/features/auth/otp/presentation/pages/otp_page.dart';
import 'package:cookify/features/auth/otp/presentation/pages/otp_page_args.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final authRoute = [
  GoRoute(
    path: '/auth',
    pageBuilder: (context, state) => MaterialPage(child: const AuthPage()),
  ),

  GoRoute(
    path: '/otp',
    pageBuilder: (context, state) {
      final args = state.extra as OtpPageArgs;

      return MaterialPage(child: OtpPage(args: args));
    },
  ),

  GoRoute(
    path: '/change-password',
    pageBuilder: (context, state) =>
        MaterialPage(child: const ChangePasswordPage()),
  ),
];
