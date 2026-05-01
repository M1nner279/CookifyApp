import 'package:cookify/features/profile/presentation/pages/profile_page.dart';
import 'package:cookify/navigations/navigator_paths.dart';
import 'package:cookify/navigations/profile_navigator_impl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigator = GoRouter(
  routes: [
    GoRoute(
      path: NavigatorPaths.splash,
      pageBuilder: (context, state) => MaterialPage(child: const Placeholder()),
    ),

    GoRoute(
      path: NavigatorPaths.auth,
      pageBuilder: (context, state) => MaterialPage(child: const Placeholder()),
    ),

    GoRoute(
      path: NavigatorPaths.changePassword,
      pageBuilder: (context, state) => MaterialPage(child: const Placeholder()),
    ),

    GoRoute(
      path: NavigatorPaths.profile,
      builder: (context, state) =>
          ProfilePage(navigator: ProfileNavigatorImpl(context)),
    ),
  ],
  initialLocation: NavigatorPaths.splash,
);
