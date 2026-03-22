import 'package:cookify/core/theme/t.dart';
import 'package:cookify/feature/home/domain/entity/recipe_preview.dart';
import 'package:cookify/feature/home/presentation/widget/home_recipe_card.dart';
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
              itemBuilder: (_, index) => HomeRecipeCard(recipe: recipes[index]),
              separatorBuilder: (_, _) => Center(
                child: Container(
                  color: T.primary(context),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 1.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              itemCount: recipes.length,
            ),
          ),
        ),

        const SizedBox(height: 16.0),
      ],
    );
  }
}
