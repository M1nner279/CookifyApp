import 'package:cookify/feature/recipe/domain/entity/recipe.dart';
import 'package:cookify/feature/recipe/presentation/widget/recipe_description_section.dart';
import 'package:cookify/feature/recipe/presentation/widget/recipe_ingredients_section.dart';
import 'package:cookify/feature/recipe/presentation/widget/recipe_photo_section.dart';
import 'package:cookify/feature/recipe/presentation/widget/recipe_steps_section.dart';
import 'package:flutter/material.dart';

class RecipeLoadedContent extends StatelessWidget {
  const RecipeLoadedContent({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: RecipePhotoSection(photoUrls: recipe.photoUrls),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
     
          SliverToBoxAdapter(child: RecipeDescriptionSection(recipe: recipe)),

          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

          SliverToBoxAdapter(
            child: RecipeIngredientsSection(ingredients: recipe.ingredients),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),

          SliverToBoxAdapter(child: RecipeStepsSection(steps: recipe.steps)),

          const SliverToBoxAdapter(child: SizedBox(height: 16.0)),
        ],
      ),
    );
  }
}
