import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/widget/recipe_description_section.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/widget/recipe_ingredients_section.dart';
import 'package:cookify/feature/recipe/recipe_detail/presentation/widget/recipe_steps_section.dart';
import 'package:cookify/shared/presentation/widget/cookify_carousel.dart';
import 'package:cookify/shared/presentation/widget/cookify_hero.dart';
import 'package:flutter/material.dart';

class RecipeLoadedContent extends StatelessWidget {
  const RecipeLoadedContent({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16.0),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

            SliverToBoxAdapter(
              child: CookifyHero(
                tag: 'recipe-${recipe.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxWidth,
                        child: CookifyCarousel(imageUrls: recipe.photoUrls),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24.0)),

            SliverToBoxAdapter(child: RecipeDescriptionSection(recipe: recipe)),

            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

            SliverToBoxAdapter(
              child: RecipeIngredientsSection(
                servingCount: recipe.servingCount,
                ingredients: recipe.ingredients,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

            SliverToBoxAdapter(child: RecipeStepsSection(steps: recipe.steps)),

            const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
          ],
        ),
      ),
    );
  }
}
