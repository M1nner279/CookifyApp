import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/auth/auth_common/presentation/pages/auth_page.dart';
import 'package:cookify/features/change_password/presentation/pages/change_password_page.dart';
import 'package:cookify/features/change_password/presentation/pages/change_password_page_args.dart';
import 'package:cookify/features/debug/debug_page.dart';
import 'package:cookify/features/otp/presentation/pages/otp_page.dart';
import 'package:cookify/features/otp/presentation/pages/otp_page_args.dart';
import 'package:cookify/features/profile/presentation/pages/profile_page.dart';
import 'package:cookify/navigations/navigators/change_password_navigator_impl.dart';
import 'package:cookify/navigations/navigator_paths.dart';
import 'package:cookify/navigations/navigators/profile_navigator_impl.dart';
import 'package:cookify/navigations/recipe_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigator = GoRouter(
  routes: [
    GoRoute(
      path: '/debug',
      pageBuilder: (context, state) => MaterialPage(child: const DebugPage()),
    ),

    GoRoute(
      path: NavigatorPaths.splash,
      pageBuilder: (context, state) => MaterialPage(child: const Placeholder()),
    ),

    GoRoute(path: NavigatorPaths.auth, builder: (context, state) => AuthPage()),

    GoRoute(
      path: NavigatorPaths.otp,
      builder: (context, state) {
        if (state.extra is! OtpPageArgs) {
          context.go(NavigatorPaths.auth);
          return const SizedBox();
        }
        final args = state.extra as OtpPageArgs;

        return OtpPage(args: args);
      },
    ),

    GoRoute(
      path: NavigatorPaths.changePassword,
      builder: (context, state) {
        if (state.extra is! ChangePasswordPageArgs) {
          return ChangePasswordPage(
          changePasswordNavigator: ChangePasswordNavigatorImpl(context),
          args: ChangePasswordPageArgs(goNext: () {
            context.go(NavigatorPaths.recipeFeed);
          },),
        );
        }
        final args = state.extra as ChangePasswordPageArgs;

        return ChangePasswordPage(
          changePasswordNavigator: ChangePasswordNavigatorImpl(context),
          args: args,
        );
      },
    ),

    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(child: child),
              
              CookifyNavigationBar(index: 4),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: NavigatorPaths.profile,
          builder: (context, state) =>
              ProfilePage(navigator: ProfileNavigatorImpl(context)),
        ),
      ],
    ),

    ...recipeRoute,
  ],
  initialLocation: '/debug',
);
