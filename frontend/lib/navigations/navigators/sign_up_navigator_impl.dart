import 'package:cookify/features/otp/presentation/pages/otp_page_args.dart';
import 'package:cookify/features/sign_up/navigators/sign_up_navigator.dart';
import 'package:cookify/navigations/navigator_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class SignUpNavigatorImpl implements SignUpNavigator {
  SignUpNavigatorImpl(this.context);

  final BuildContext context;

  @override
  void goOtp(String login) {
    context.go(
      NavigatorPaths.otp,
      extra: OtpPageArgs(login: login, nextPage: NavigatorPaths.recipeFeed),
    );
  }

  @override
  void goRecipeFeed() {
    context.go(NavigatorPaths.recipeFeed);
  }
}
