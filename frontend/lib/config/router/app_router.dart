import 'package:cookify/feature/auth/auth_common/presentation/pages/auth_page.dart';
import 'package:cookify/feature/auth/change_password/di/change_password_di.dart';
import 'package:cookify/feature/auth/change_password/presentation/bloc/change_password_cubit.dart';
import 'package:cookify/feature/auth/change_password/presentation/page/change_password_page_content.dart';
import 'package:cookify/feature/auth/otp/presentation/page/otp_page.dart';
import 'package:cookify/feature/recipe/recipe_feed/presentation/bloc/home_cubit.dart';
import 'package:cookify/feature/recipe/recipe_feed/presentation/page/home_page.dart';
import 'package:cookify/feature/profile/presentation/page/profile_page.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/bloc/recipe_cubit.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/page/recipe_page.dart';
import 'package:cookify/feature/recipe/recipe_saved_list/presentation/pages/recipe_saved_list_page.dart';
import 'package:cookify/service/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return SafeArea(child: child);
      },
      routes: [
        GoRoute(
          path: RecipePage.route,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'];

            return NoTransitionPage(
              child: BlocProvider<RecipeCubit>.value(
                value: DI.getIt(param1: id),
                child: const RecipePage(),
              ),
            );
          },
        ),

        GoRoute(
          path: RecipePage.route,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'];

            return NoTransitionPage(
              child: BlocProvider<RecipeCubit>.value(
                value: DI.getIt(param1: id),
                child: const RecipePage(),
              ),
            );
          },
        ),

        GoRoute(
          path: '/auth',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: AuthPage()),
          routes: [
            GoRoute(
              path: '/otp',
              pageBuilder: (context, state) {
                final Future<bool> Function(String) verifyCode =
                    (state.extra as Map<String, dynamic>)['verifyCode'];
                final Future<void> Function() resendCode =
                    (state.extra as Map<String, dynamic>)['resendCode'];
                final bool isPasswordRestore =
                    (state.extra
                        as Map<String, dynamic>)['isPasswordRestore'] ??
                    false;
                return NoTransitionPage(
                  child: OtpPage(
                    verifyCode: verifyCode,
                    resendCode: resendCode,
                    isPasswordRestore: isPasswordRestore,
                  ),
                );
              },
            ),
            GoRoute(
              path: '/change-password',
              pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider<ChangePasswordCubit>.value(
                  value: ChangePasswordDi.getIt<ChangePasswordCubit>(),
                  child: const ChangePasswordPageContent(),
                ),
              ),
            ),
          ],
        ),

        GoRoute(
          path: HomePage.route,
          pageBuilder: (context, state) => NoTransitionPage(
            child: BlocProvider<HomeCubit>.value(
              value: DI.getIt(),
              child: const HomePage(),
            ),
          ),
          routes: [
            GoRoute(
              path: RecipePage.route,
              pageBuilder: (context, state) {
                final id = state.pathParameters['id'];

                return NoTransitionPage(
                  child: BlocProvider<RecipeCubit>.value(
                    value: DI.getIt(param1: id),
                    child: const RecipePage(),
                  ),
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: '/saved',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: RecipeSavedListPage()),
          routes: [
            GoRoute(
              path: RecipePage.route,
              pageBuilder: (context, state) {
                final id = state.pathParameters['id'];

                return NoTransitionPage(
                  child: BlocProvider<RecipeCubit>.value(
                    value: DI.getIt(param1: id),
                    child: const RecipePage(),
                  ),
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfilePage()),
        ),
      ],
    ),
  ],
  initialLocation: '/auth',
);
