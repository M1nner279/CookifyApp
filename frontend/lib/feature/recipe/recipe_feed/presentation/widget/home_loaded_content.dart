import 'package:cookify/feature/recipe/recipe_feed/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/recipe/recipe_feed/presentation/widget/home_recipe_card.dart';
import 'package:cookify/shared/presentation/widget/cookify_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeLoadedContent extends StatelessWidget {
  const HomeLoadedContent({super.key, required this.recipes});

  final List<RecipePreview> recipes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: ListView.separated(
              padding: const .fromLTRB(
                16.0,
                16.0,
                16.0,
                16.0 + CookifyNavigationBar.barHeight,
              ),
              itemBuilder: (_, index) => HomeRecipeCard(recipe: recipes[index]),
              separatorBuilder: (_, _) => const SizedBox(height: 24.0),
              itemCount: recipes.length,
            ),
          ),
        ),
      ],
    );
  }
}
