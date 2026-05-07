import 'package:cookify/features/change_password/presentation/pages/change_password_page_args.dart';
import 'package:cookify/features/profile/navigator/profile_navigator.dart';
import 'package:cookify/navigations/navigator_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class ProfileNavigatorImpl implements ProfileNavigator {
  ProfileNavigatorImpl(this.context);

  final BuildContext context;

  @override
  void pushChangePassword() {
    context.push(
      NavigatorPaths.changePassword,
      extra: ChangePasswordPageArgs(goNext: context.pop),
    );
  }

  @override
  void goAuth() {
    context.go(NavigatorPaths.auth);
  }
}
