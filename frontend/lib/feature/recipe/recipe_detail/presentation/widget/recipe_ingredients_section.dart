import 'dart:math';

import 'package:cookify/shared/presentation/widget/cookify_card.dart';
import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/feature/recipe/recipe_common/domain/entities/recipe_ingredient.dart';
import 'package:flutter/material.dart';

class RecipeIngredientsSection extends StatefulWidget {
  const RecipeIngredientsSection({
    super.key,
    required this.servingCount,
    required this.ingredients,
  });

  final double servingCount;
  final List<RecipeIngredient> ingredients;

  @override
  State<RecipeIngredientsSection> createState() =>
      _RecipeIngredientsSectionState();
}

class _RecipeIngredientsSectionState extends State<RecipeIngredientsSection> {
  late double _servingCount = widget.servingCount;
  late List<RecipeIngredient> _ingredients = [...widget.ingredients];

  @override
  Widget build(BuildContext context) {
    return CookifyCard(
      child: Padding(
        padding: const .all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            Text(
              S.of(context).recipeIngredientsSectionTitle,
              style: const TextStyle(
                color: const Color(0xFFF5E6D3),
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                height: 28.0 / 20.0,
              ),
            ),

            Center(
              child: _ServingCount(
                onServingCountChanged: (newServingCount, newIngredients) {
                  setState(() {
                    _servingCount = newServingCount;
                    _ingredients = newIngredients;
                  });
                },
                servingCount: _servingCount,
                ingredients: _ingredients,
              ),
            ),

            Flexible(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) =>
                    _Ingredient(ingredient: _ingredients[index]),
                separatorBuilder: (_, _) => Container(
                  color: const Color(0x0F000000),
                  width: double.infinity,
                  height: 1.0,
                  margin: .symmetric(vertical: 16.0),
                ),
                itemCount: _ingredients.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServingCount extends StatelessWidget {
  const _ServingCount({
    required this.onServingCountChanged,
    required this.servingCount,
    required this.ingredients,
  });

  final void Function(
    double newServingCount,
    List<RecipeIngredient> newIngredients,
  )
  onServingCountChanged;
  final double servingCount;
  final List<RecipeIngredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(2.0),
      decoration: BoxDecoration(
        color: const Color(0x19E5C9A8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 8.0,
        children: [
          IconButton(
            onPressed: () {
              final newServingCount = max(0.5, servingCount - 0.5);
              final newIngredients = ingredients
                  .map(
                    (ingredient) => ingredient.copyWith(
                      amount:
                          ingredient.amount / servingCount * newServingCount,
                    ),
                  )
                  .toList();
              onServingCountChanged(newServingCount, newIngredients);
            },
            icon: Icon(Icons.remove, size: 20.0, color: const Color(0xFFF5E6D3),),
          ),

          Text(
            S.of(context).recipeIngredientsSectionServingCount(servingCount),
            style: const TextStyle(
              color: const Color(0xFFF5E6D3),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.0,
              height: 20.0 / 14.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),

          IconButton(
            onPressed: () {
              final newServingCount = min(20.0, servingCount + 0.5);
              final newIngredients = ingredients
                  .map(
                    (ingredient) => ingredient.copyWith(
                      amount:
                          ingredient.amount / servingCount * newServingCount,
                    ),
                  )
                  .toList();
              onServingCountChanged(newServingCount, newIngredients);
            },
            icon: Icon(Icons.add, size: 20.0, color: const Color(0xFFF5E6D3),),
          ),
        ],
      ),
    );
  }
}

class _Ingredient extends StatelessWidget {
  const _Ingredient({required this.ingredient});

  final RecipeIngredient ingredient;

  @override
  Widget build(BuildContext context) {
    final quantity = ingredient.amount
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'\.?0+$'), '');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8.0,
      children: [
        Text(
          ingredient.name,
          style: const TextStyle(
            color: const Color(0xFFF5E6D3),
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.0,
            height: 24.0 / 16.0,
          ),
        ),

        Text(
          '$quantity${ingredient.unit}',
          style: const TextStyle(
            color: const Color(0xFFF5E6D3),
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.0,
            height: 24.0 / 16.0,
          ),
        ),
      ],
    );
  }
}
