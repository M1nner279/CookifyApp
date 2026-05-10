import 'package:cookify/core/presentation/widgets/cookify_navigation_bar.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page_args.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/pages/recipe_feed_page.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/pages/recipe_drafts_page.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/pages/recipe_form_page.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/pages/recipe_form_page_args.dart';
import 'package:cookify/features/recipe/recipe_saved/presentation/pages/recipe_saved_page.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_form_page.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page_args.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final recipeRoute = [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) =>
        NoTransitionPage(key: state.pageKey, child: const RecipeFeedPage()),
  ),

  GoRoute(
    path: '/recipes/:id',
    pageBuilder: (context, state) {
      final args = state.extra as RecipeDetailPageArgs;

      return NoTransitionPage(
        key: state.pageKey,
        child: RecipeDetailPage(args: args),
      );
    },
  ),

  ShellRoute(
    pageBuilder: (context, state, child) {
      return NoTransitionPage(
            key: state.pageKey,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Expanded(child: child),

                CookifyNavigationBar(index: 1),
              ],
            ),
          ),
        ),
      );
    },
    routes: [
      GoRoute(
        path: '/search-form',
        builder: (context, state) => RecipeSearchFormPage(),
      ),

      GoRoute(
        path: '/search',
        pageBuilder: (context, state) {
          final args = state.extra as RecipeSearchPageArgs;

          return NoTransitionPage(
            key: state.pageKey,
            child: RecipeSearchPage(args: args),
          );
        },
      ),
    ],
  ),

  GoRoute(
    path: '/create',
    pageBuilder: (context, state) {
      final args = state.extra is RecipeFormPageArgs
          ? state.extra as RecipeFormPageArgs
          : const RecipeFormPageArgs();
      return NoTransitionPage(
        key: state.pageKey,
        child: RecipeFormPage(args: args),
      );
    },
  ),

  GoRoute(
    path: '/drafts',
    pageBuilder: (context, state) =>
        NoTransitionPage(
            key: state.pageKey,child: const RecipeDraftsPage()),
  ),

  GoRoute(
    path: '/saved',
    pageBuilder: (context, state) =>
        NoTransitionPage(
            key: state.pageKey,child: const RecipeSavedPage()),
  ),
];
