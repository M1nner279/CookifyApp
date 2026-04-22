import 'package:cookify/core/presentation/widgets/cookify_cached_network_image.dart';
import 'package:cookify/features/recipe/recipe_common/domain/entities/recipe_step_entity.dart';
import 'package:flutter/material.dart';

class RecipeDetailStepsCard extends StatelessWidget {
  const RecipeDetailStepsCard({super.key, required this.steps});

  final List<RecipeStepEntity> steps;

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
        spacing: 26.0,
        children: [
          Text(
            'Шаги',
            style: const TextStyle(
              color: Color(0xFFE5C9A8),
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
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.index, required this.step});

  final int index;
  final RecipeStepEntity step;

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
                color: const Color(0xFFE5C9A8),
                shape: BoxShape.circle,
              ),
              width: 32.0,
              height: 32.0,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: const Color(0xFF1A0F0A),
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
                style: const TextStyle(
                  color: Color(0xFFE5C9A8),
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

        Text(
          step.description,
          style: TextStyle(color: const Color(0xCCE5C9A8)),
        ),
      ],
    );
  }
}
