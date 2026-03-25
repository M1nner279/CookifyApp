import 'package:cookify/shared/presentation/widget/cookify_cached_network_image.dart';
import 'package:cookify/shared/presentation/widget/cookify_card.dart';
import 'package:cookify/config/l10n/s.dart';
import 'package:cookify/config/theme/t.dart';
import 'package:cookify/shared/domain/entity/recipe_step.dart';
import 'package:flutter/material.dart';

class RecipeStepsSection extends StatelessWidget {
  const RecipeStepsSection({super.key, required this.steps});

  final List<RecipeStep> steps;

  @override
  Widget build(BuildContext context) {
    return CookifyCard(
      child: Padding(
        padding: const .all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 26.0,
          children: [
            Text(
              S.of(context).recipeStepsSectionTitle,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                height: 28.0 / 20.0,
              ),
            ),

            Flexible(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) =>
                    _Step(index: index, step: steps[index]),
                separatorBuilder: (_, _) => const SizedBox(height: 40.0),
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
  const _Step({required this.index, required this.step});

  final int index;
  final RecipeStep step;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 18.0,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: T.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              width: 32.0,
              height: 32.0,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: T.of(context).colorScheme.primary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.0,
                  height: 24.0 / 16.0,
                ),
              ),
            ),

            Expanded(
              child: Text(
                step.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.0,
                  height: 28.0 / 18.0,
                ),
              ),
            ),
          ],
        ),

        LayoutBuilder(
          builder: (context, constraints) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CookifyCachedNetworkImage(
                step.photoUrl,
                width: constraints.maxWidth,
                height: constraints.maxWidth * 2 / 3,
              ),
            );
          },
        ),

        Text(step.description),
      ],
    );
  }
}
