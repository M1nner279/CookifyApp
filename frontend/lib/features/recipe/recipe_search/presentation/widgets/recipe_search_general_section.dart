import 'package:cookify/core/presentation/widgets/cookify_text_field.dart';
import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/widgets/recipe_search_difficulty_filter.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/widgets/recipe_search_section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeSearchGeneralSection extends StatelessWidget {
  const RecipeSearchGeneralSection({
    super.key,
    required this.difficulties,
    required this.maxCookingTimeController,
    required this.minCarbohydratesController,
    required this.maxCarbohydratesController,
    required this.minProteinsController,
    required this.maxProteinsController,
    required this.minFatsController,
    required this.maxFatsController,
    required this.minCaloriesController,
    required this.maxCaloriesController,
  });

  final List<RecipeDifficulty> difficulties;
  final TextEditingController maxCookingTimeController;
  final TextEditingController minCarbohydratesController;
  final TextEditingController maxCarbohydratesController;
  final TextEditingController minProteinsController;
  final TextEditingController maxProteinsController;
  final TextEditingController minFatsController;
  final TextEditingController maxFatsController;
  final TextEditingController minCaloriesController;
  final TextEditingController maxCaloriesController;

  @override
  Widget build(BuildContext context) {
    return RecipeSearchSectionCard(
      title: 'Общее',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          RecipeSearchDifficultyFilter(difficulties: difficulties),

          CookifyTextField(
            controller: maxCookingTimeController,
            inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            maxLength: 5,
            onChanged: (_) {},
            hint: 'Максимальное время приготовления',
          ),

          _MinMaxTextField(
            title: 'Калории',
            minController: minCaloriesController,
            maxController: maxCaloriesController,
          ),

          _MinMaxTextField(
            title: 'Белки',
            minController: minProteinsController,
            maxController: maxProteinsController,
          ),

          _MinMaxTextField(
            title: 'Жиры',
            minController: minFatsController,
            maxController: maxFatsController,
          ),

          _MinMaxTextField(
            title: 'Углеводы',
            minController: minCarbohydratesController,
            maxController: maxCarbohydratesController,
          ),
        ],
      ),
    );
  }
}

class _MinMaxTextField extends StatelessWidget {
  const _MinMaxTextField({
    required this.title,
    required this.minController,
    required this.maxController,
  });

  final String title;
  final TextEditingController minController;
  final TextEditingController maxController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFE5C9A8),
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
            height: 24.0 / 18.0,
          ),
        ),

        Row(
          spacing: 24.0,
          children: [
            Expanded(
              child: CookifyTextField(
                controller: minController,
                inputFormatter: FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
                maxLength: 5,
                hint: 'Мин',
              ),
            ),

            Expanded(
              child: CookifyTextField(
                controller: maxController,
                inputFormatter: FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
                maxLength: 5,
                hint: 'Макс',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
