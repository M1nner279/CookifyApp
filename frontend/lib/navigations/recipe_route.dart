import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page_args.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/pages/recipe_feed_page.dart';
import 'package:cookify/features/recipe/recipe_form/presentation/pages/recipe_form_page.dart';
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
        MaterialPage(child: const RecipeFeedPage()),
  ),

  GoRoute(
    path: '/recipes/:id',
    pageBuilder: (context, state) {
      final args = state.extra as RecipeDetailPageArgs;

      return MaterialPage(child: RecipeDetailPage(args: args));
    },
  ),

  GoRoute(
    path: '/search-form',
    pageBuilder: (context, state) =>
        MaterialPage(child: const RecipeSearchFormPage()),
  ),

  GoRoute(
    path: '/search',
    pageBuilder: (context, state) {
      final args = state.extra as RecipeSearchPageArgs;

      return MaterialPage(child: RecipeSearchPage(args: args));
    },
  ),

  GoRoute(
    path: '/create',
    pageBuilder: (context, state) =>
        MaterialPage(child: const RecipeFormPage()),
  ),

  GoRoute(
    path: '/saved',
    pageBuilder: (context, state) =>
        MaterialPage(child: const RecipeSavedPage()),
  ),
];
