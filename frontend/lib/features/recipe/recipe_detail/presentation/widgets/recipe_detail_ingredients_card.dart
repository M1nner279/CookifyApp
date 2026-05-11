import 'package:cookify/core/l10n/my_locale.dart';
import 'dart:math';

import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_ingredient_entity.dart';
import 'package:flutter/material.dart';

class RecipeDetailIngredientsCard extends StatefulWidget {
  const RecipeDetailIngredientsCard({
    super.key,
    required this.servingCount,
    required this.ingredients,
  });

  final double servingCount;
  final List<RecipeIngredientEntity> ingredients;

  @override
  State<RecipeDetailIngredientsCard> createState() =>
      _RecipeDetailIngredientsCardState();
}

class _RecipeDetailIngredientsCardState
    extends State<RecipeDetailIngredientsCard> {
  late double _servingCount = widget.servingCount;
  late List<RecipeIngredientEntity> _ingredients = [...widget.ingredients];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2C1C16),
        border: Border.all(color: const Color(0x1AE5C9A8)),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.0,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyLocale.of(context).recipeDetailIngredients,
                style: const TextStyle(
                  color: Color(0xFFE5C9A8),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  height: 28.0 / 20.0,
                ),
                overflow: TextOverflow.ellipsis,
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
            ],
          ),

          Flexible(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) =>
                  _Ingredient(ingredient: _ingredients[index]),
              separatorBuilder: (_, _) => Container(
                color: const Color(0x1AFFFFFF),
                width: double.infinity,
                height: 1.0,
                margin: .symmetric(vertical: 16.0),
              ),
              itemCount: _ingredients.length,
            ),
          ),
        ],
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
    List<RecipeIngredientEntity> newIngredients,
  )
  onServingCountChanged;
  final double servingCount;
  final List<RecipeIngredientEntity> ingredients;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(2.0),
      decoration: BoxDecoration(
        color: const Color(0x0DFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 2.0,
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
            icon: const Icon(
              Icons.remove,
              size: 18.0,
              color: Color(0xFFE5C9A8),
            ),
          ),

          Text(
            MyLocale.of(context).commonServingsDouble(servingCount),
            style: const TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.0,
              height: 20.0 / 12.0,
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
            icon: const Icon(Icons.add, size: 18.0, color: Color(0xFFE5C9A8)),
          ),
        ],
      ),
    );
  }
}

class _Ingredient extends StatelessWidget {
  const _Ingredient({required this.ingredient});

  final RecipeIngredientEntity ingredient;

  @override
  Widget build(BuildContext context) {
    final quantity = ingredient.amount
        .toStringAsFixed(2)
        .replaceAll(RegExp(r'\.?0+$'), '');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8.0,
      children: [
        Expanded(
          child: Text(
            ingredient.name,
            style: const TextStyle(
              color: Color(0xFFE5C9A8),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.0,
              height: 24.0 / 16.0,
            ),
            //overflow: TextOverflow.ellipsis,
          ),
        ),

        Text(
          '$quantity${ingredient.unit}',
          style: const TextStyle(
            color: Color(0xFFE5C9A8),
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
