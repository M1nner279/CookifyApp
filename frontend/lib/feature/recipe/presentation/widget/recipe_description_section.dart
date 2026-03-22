import 'package:cookify/common/presentation/widget/cookify_card.dart';
import 'package:cookify/core/l10n/s.dart';
import 'package:cookify/core/theme/t.dart';
import 'package:cookify/feature/recipe/domain/entity/category.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDescriptionSection extends StatelessWidget {
  const RecipeDescriptionSection({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CookifyCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            Text(recipe.name, style: T.headlineLarge(context)),

            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: recipe.categories
                  .map((category) => _Category(category: category))
                  .toList(),
            ),

            Row(
              spacing: 4.0,
              children: [
                Text(
                  S
                      .of(context)
                      .recipeDescriptionSectionCookingTime(recipe.cookingTime),
                  style: T.bodyMedium(context),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: recipe.difficulty.color(),
                    border: Border.all(color: T.secondary(context)),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    recipe.difficulty.text(context),
                    style: T.bodyMedium(context),
                  ),
                ),
              ],
            ),

            Text(
              S
                  .of(context)
                  .recipeDescriptionSectionCpfc(
                    recipe.cpfc.calories,
                    recipe.cpfc.carbohydrates,
                    recipe.cpfc.fats,
                    recipe.cpfc.proteins,
                  ),
              style: T.bodyMedium(context),
            ),

            Text(recipe.description, style: T.bodyMedium(context)),
          ],
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: T.primary(context),
        border: Border.all(color: T.secondary(context)),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(category.name, style: T.bodyMedium(context)),
    );
  }
}
