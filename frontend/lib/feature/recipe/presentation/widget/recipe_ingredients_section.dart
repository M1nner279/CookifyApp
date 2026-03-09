import 'package:cookify/common/presentation/widget/cookify_card.dart';
import 'package:cookify/core/l10n/s.dart';
import 'package:cookify/core/theme/t.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe_ingredient.dart';
import 'package:cookify/feature/recipe/presentation/widget/recipe_section_title.dart';
import 'package:flutter/material.dart';

class RecipeIngredientsSection extends StatelessWidget {
  const RecipeIngredientsSection({super.key, required this.ingredients});

  final List<RecipeIngredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CookifyCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            RecipeSectionTitle(S.of(context).recipeIngredientsSectionTitle),

            Flexible(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) =>
                    _Ingredient(ingredient: ingredients[index]),
                separatorBuilder: (_, _) => const SizedBox(height: 4.0),
                itemCount: ingredients.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Ingredient extends StatelessWidget {
  const _Ingredient({required this.ingredient});

  final RecipeIngredient ingredient;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        Container(
          decoration: BoxDecoration(
            color: T.secondary(context),
            shape: BoxShape.circle,
          ),
          width: 8.0,
          height: 8.0,
        ),

        Text(
          '${ingredient.name}${ingredient.comment != null ? ' (${ingredient.comment})' : ''} —',
          style: T.bodyMedium(context),
        ),

        Text(
          '${ingredient.quantity} ${int.tryParse(ingredient.quantity) != null ? '${ingredient.unit.name} ' : ''}',
          style: T.bodyMedium(context),
        ),
      ],
    );
  }
}
