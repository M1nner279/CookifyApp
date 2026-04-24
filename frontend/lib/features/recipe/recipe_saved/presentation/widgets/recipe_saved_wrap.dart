import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_saved/presentation/widgets/recipe_saved_preview_card.dart';
import 'package:flutter/material.dart';

class RecipeSavedWrap extends StatelessWidget {
  const RecipeSavedWrap({super.key, required this.recipes});

  final List<RecipePreviewEntity> recipes;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 4,
        spacing: 8,
        children: [...recipes.map((e) => RecipeSavedPreviewCard(recipe: e))],
      ),
    );
  }
}
