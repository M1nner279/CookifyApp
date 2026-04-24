import 'package:cookify/core/presentation/widgets/cookify_pagination_list_view.dart';
import 'package:cookify/features/recipe/recipe_feed/domain/entities/recipe_preview_entity.dart';
import 'package:cookify/features/recipe/recipe_feed/presentation/widgets/recipe_feed_recipe_preview_card.dart';
import 'package:flutter/material.dart';

class RecipeFeedRecipeList extends StatelessWidget {
  const RecipeFeedRecipeList({
    super.key,
    required this.recipes,
    required this.isLoading,
    required this.controller,
    this.onAtBottom,
  });

  final List<RecipePreviewEntity> recipes;
  final bool isLoading;
  final ScrollController controller;
  final VoidCallback? onAtBottom;

  @override
  Widget build(BuildContext context) {
    return CookifyPaginationListView(
      items: recipes
          .map((e) => RecipeFeedRecipePreviewCard(recipe: e))
          .toList(),
      isLoading: isLoading,
      onAtBottom: onAtBottom ?? () {},
      controller: controller,
    );
  }
}
