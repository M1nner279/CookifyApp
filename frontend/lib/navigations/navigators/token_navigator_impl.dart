import 'package:cookify/features/token/navigators/token_navigator.dart';
import 'package:cookify/navigations/navigator_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class TokenNavigatorImpl implements TokenNavigator {
  TokenNavigatorImpl(this.context);

  final BuildContext context;

  @override
  void goAuth() {
    context.go(NavigatorPaths.auth);
  }
}
