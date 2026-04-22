import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page.dart';
import 'package:cookify/features/recipe/recipe_detail/presentation/pages/recipe_detail_page_args.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/pages/recipe_feed_page.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_form_page.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_page_args.dart';
import 'package:go_router/go_router.dart';

final recipeRoute = [
  GoRoute(path: '/', builder: (context, state) => const RecipeFeedPage()),

  GoRoute(
    path: '/recipes/:id',
    builder: (context, state) {
      final args = state.extra as RecipeDetailPageArgs;

      return RecipeDetailPage(args: args);
    },
  ),

  GoRoute(
    path: '/search-form',
    builder: (context, state) => const RecipeSearchFormPage(),
  ),

  GoRoute(
    path: '/search',
    builder: (context, state) {
      final args = state.extra as RecipeSearchPageArgs;

      return RecipeSearchPage(args: args,);
    },
  ),
];
