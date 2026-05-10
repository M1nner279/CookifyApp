import 'package:cookify/features/recipe/recipe_common/domain/entities/category_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/cpfc_entity.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/extensions/styled_recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_detail/domain/entities/recipe_detail_entity.dart';
import 'package:flutter/material.dart';

class RecipeDetailInfoCard extends StatelessWidget {
  const RecipeDetailInfoCard({super.key, required this.recipe});

  final RecipeDetailEntity recipe;

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
              color: Color(0xFFE5C9A8),
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
              color: Color(0xCCF5E6D3),
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.0,
              height: 22.8 / 14.0,
            ),
          ),
        ],
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
      padding: const .symmetric(horizontal: 12.0, vertical: 4.0),
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

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const .symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(9999.0),
      ),
      child: Text(
        category.name.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFFE5C9A8),
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
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
        Icon(Icons.access_time, size: 20.0, color: const Color(0xFFE5C9A8)),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Время',
              style: const TextStyle(
                color: Color(0x99E5C9A8),
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.0,
                height: 15.0 / 10.0,
              ),
            ),

            Text(
              '$cookingTime мин',
              style: const TextStyle(
                color: Color(0xFFE5C9A8),
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

  final CpfcEntity cpfc;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        _Cpf(
          sign: 'Б',
          grams: cpfc.proteins,
        ),

        _Cpf(
          sign: 'Ж',
          grams: cpfc.fats,
        ),

        _Cpf(
          sign: 'У',
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
        color: const Color(0x0DFFFFFF),
        border: Border.all(color: const Color(0x1AFFFFFF)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        spacing: 6.0,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFE5C9A8),
              borderRadius: BorderRadius.circular(4.0),
            ),
            width: 21.0,
            height: 21.0,
            child: Text(
              sign,
              style: TextStyle(
                color: const Color(0xFF1A0F0A),
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
                color: const Color(0xFFE5C9A8),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
                height: 16.0 / 12.0,
              ),
              children: [
                TextSpan(
                  text: 'г',
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
      padding: const .symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: const Color(0x33E5C9A8),
        border: Border.all(color: const Color(0x4DE5C9A8)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        spacing: 4.0,
        children: [
          Icon(
            Icons.local_fire_department,
            size: 14.0,
            color: const Color(0xFFE5C9A8),
          ),

          RichText(
            text: TextSpan(
              text: '$calories',
              style: TextStyle(
                color: const Color(0xFFE5C9A8),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0,
                height: 16.0 / 12.0,
              ),
              children: [
                TextSpan(
                  text: 'ккал',
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
