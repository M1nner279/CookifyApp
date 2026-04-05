import 'package:cookify/feature/auth/presentation/bloc/login_cubit.dart';
import 'package:cookify/feature/auth/presentation/page/login_page.dart';
import 'package:cookify/feature/auth/presentation/page/recover_password_page.dart';
import 'package:cookify/feature/auth/presentation/page/register_page.dart';
import 'package:cookify/feature/home/presentation/bloc/home_cubit.dart';
import 'package:cookify/feature/home/presentation/page/home_page.dart';
import 'package:cookify/feature/profile/presentation/page/profile_page.dart';
import 'package:cookify/feature/recipe/presentation/bloc/recipe_cubit.dart';
import 'package:cookify/feature/recipe/presentation/page/recipe_page.dart';
import 'package:cookify/service/di/auth_di.dart';
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
          path: LoginPage.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider<LoginCubit>.value(
                value: AuthDI.getIt(),
                child: const LoginPage(),
              ),
            );
          },
        ),

        GoRoute(
          path: RegisterPage.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider<LoginCubit>.value(
                value: AuthDI.getIt(),
                child: const RegisterPage(),
              ),
            );
          },
        ),

        GoRoute(
          path: RecoverPasswordPage.route,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              child: BlocProvider<LoginCubit>.value(
                value: AuthDI.getIt(),
                child: const RecoverPasswordPage(),
              ),
            );
          },
        ),

        GoRoute(
          path: HomePage.route,
          builder: (context, state) {
            return BlocProvider<HomeCubit>.value(
              value: DI.getIt(),
              child: const HomePage(),
            );
          },
          routes: [
            GoRoute(
              path: RecipePage.route,
              builder: (context, state) {
                final id = state.pathParameters['id'];

                return BlocProvider<RecipeCubit>.value(
                  value: DI.getIt(param1: id),
                  child: const RecipePage(),
                );
              },
            ),
          ],
        ),

        GoRoute(
          path: '/profile',
          builder: (context, state) {
            return const ProfilePage();
          },
        ),
      ],
    ),
  ],
  initialLocation: LoginPage.route,
);
