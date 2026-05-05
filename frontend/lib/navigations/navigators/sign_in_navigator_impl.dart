import 'package:cookify/features/sign_in/navigators/sign_in_navigator.dart';
import 'package:cookify/navigations/navigator_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class SignInNavigatorImpl implements SignInNavigator {
  SignInNavigatorImpl(this.context);

  final BuildContext context;

  @override
  void goRecipeFeed() {
    context.go(NavigatorPaths.recipeFeed);
  }
}