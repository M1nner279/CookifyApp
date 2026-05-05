import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_saved/presentation/widgets/recipe_saved_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecipeSavedWrap extends StatelessWidget {
  const RecipeSavedWrap({super.key, required this.recipes});

  final List<RecipePreviewEntity> recipes;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2, 
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeSavedPreviewCard(recipe: recipes[index]);
      },
    );
  }
}

