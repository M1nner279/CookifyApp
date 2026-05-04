import 'package:cookify/features/otp/presentation/pages/otp_page_args.dart';
import 'package:cookify/features/restore/navigators/restore_navigator.dart';
import 'package:cookify/navigations/navigator_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class RestoreNavigatorImpl implements RestoreNavigator {
  RestoreNavigatorImpl(this.context);

  final BuildContext context;

  @override
  void goOtp(String login) {
    context.go(
      NavigatorPaths.otp,
      extra: OtpPageArgs(login: login, nextPage: NavigatorPaths.changePassword),
    );
  }
}
