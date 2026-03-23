import 'package:cookify/config/theme/t.dart';
import 'package:cookify/shared/config/enum/recipe_difficulty.dart';
import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:cookify/shared/presentation/widget/cookify_card.dart';
import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/shared/domain/entity/category.dart';
import 'package:cookify/shared/domain/entity/recipe.dart';
import 'package:flutter/material.dart';

class RecipeDescriptionSection extends StatelessWidget {
  const RecipeDescriptionSection({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return CookifyCard(
      child: Padding(
        padding: const .all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15.3,
          children: [
            Row(
              spacing: 8.0,
              children: [
                _Difficulty(difficulty: recipe.difficulty),

                Expanded(
                  child: SizedBox(
                    height: 23.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (_, index) =>
                          _Category(category: recipe.categories[index]),
                      separatorBuilder: (_, _) => const SizedBox(width: 6.0),
                      itemCount: recipe.categories.length,
                    ),
                  ),
                ),
              ],
            ),

            Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.2,
                height: 37.5 / 30.0,
              ),
            ),

            _CookingTime(cookingTime: recipe.cookingTime),

            _Cpfc(cpfc: recipe.cpfc),

            const SizedBox.shrink(),

            Text(
              recipe.description,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
                height: 22.8 / 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Difficulty extends StatelessWidget {
  const _Difficulty({required this.difficulty});

  final RecipeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .fromLTRB(12.0, 4.0, 12.0, 6.0),
      decoration: BoxDecoration(
        color: difficulty.color(),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        difficulty.text(context),
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          height: 15.0 / 10.0,
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
      padding: const .fromLTRB(12.0, 4.0, 12.0, 6.0),
      decoration: BoxDecoration(
        color: const Color(0x19000000),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        category.name,
        style: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.0,
          height: 15.0 / 10.0,
        ),
      ),
    );
  }
}

class _CookingTime extends StatelessWidget {
  const _CookingTime({required this.cookingTime});

  final int cookingTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.0,
      children: [
        Icon(Icons.access_time, size: 20.0),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).recipeDescriptionSectionTime,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.0,
                height: 15.0 / 10.0,
              ),
            ),

            Text(
              S.of(context).recipeDescriptionSectionCookingTime(cookingTime),
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
                height: 24.0 / 16.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Cpfc extends StatelessWidget {
  const _Cpfc({required this.cpfc});

  final Cpfc cpfc;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        _Cpf(
          sign: S.of(context).recipeDescriptionSectionProteins,
          grams: cpfc.proteins,
        ),

        _Cpf(
          sign: S.of(context).recipeDescriptionSectionFats,
          grams: cpfc.fats,
        ),

        _Cpf(
          sign: S.of(context).recipeDescriptionSectionCarbs,
          grams: cpfc.carbohydrates,
        ),

        _Calories(calories: cpfc.calories),
      ],
    );
  }
}

class _Cpf extends StatelessWidget {
  const _Cpf({required this.sign, required this.grams});

  final String sign;
  final int grams;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0x19000000),
        border: Border.all(color: const Color(0x08000000)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        spacing: 6.0,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: T.secondary(context),
              borderRadius: BorderRadius.circular(4.0),
            ),
            width: 21.0,
            height: 21.0,
            child: Text(
              sign,
              style: TextStyle(
                color: T.primary(context),
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.0,
                height: 16.5 / 11.0,
              ),
            ),
          ),

          RichText(
            text: TextSpan(
              text: '$grams',
              style: TextStyle(
                color: T.secondary(context),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
                height: 16.0 / 12.0,
              ),
              children: [
                TextSpan(
                  text: S.of(context).recipeDescriptionSectionGrams,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    height: 16.0 / 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Calories extends StatelessWidget {
  const _Calories({required this.calories});

  final int calories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0x33E8B86D),
        border: Border.all(color: const Color(0x4CE8B86D)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        spacing: 6.0,
        children: [
          Icon(Icons.local_fire_department, size: 16.0),

          RichText(
            text: TextSpan(
              text: '$calories',
              style: TextStyle(
                color: T.secondary(context),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
                height: 16.0 / 12.0,
              ),
              children: [
                TextSpan(
                  text: S.of(context).recipeDescriptionSectionCalories,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.0,
                    height: 16.0 / 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
