import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/debug/debug_page.dart';
import 'package:cookify/navigations/auth_route.dart';
import 'package:cookify/navigations/recipe_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/debug', builder: (context, state) => const DebugPage()),

    ...authRoute,

    ...recipeRoute,
  ],
  initialLocation: '/debug',
);
