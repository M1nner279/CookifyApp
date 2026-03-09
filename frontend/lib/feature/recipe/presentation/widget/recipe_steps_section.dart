import 'package:cookify/common/presentation/widget/cookify_cached_network_image.dart';
import 'package:cookify/common/presentation/widget/cookify_card.dart';
import 'package:cookify/core/l10n/s.dart';
import 'package:cookify/core/theme/t.dart';
import 'package:cookify/feature/recipe/domain/entity/recipe_step.dart';
import 'package:cookify/feature/recipe/presentation/widget/recipe_section_title.dart';
import 'package:flutter/material.dart';

class RecipeStepsSection extends StatelessWidget {
  const RecipeStepsSection({super.key, required this.steps});

  final List<RecipeStep> steps;

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
            RecipeSectionTitle(S.of(context).recipeStepsSectionTitle),

            Flexible(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) => _Step(step: steps[index]),
                separatorBuilder: (_, _) => const SizedBox(height: 8.0),
                itemCount: steps.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.step});

  final RecipeStep step;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 2.0,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: CookifyCachedNetworkImage(
                step.imageUrl,
                width: constraints.maxWidth * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            );
          },
        ),

        Text(step.description, style: T.bodyMedium(context)),
      ],
    );
  }
}
