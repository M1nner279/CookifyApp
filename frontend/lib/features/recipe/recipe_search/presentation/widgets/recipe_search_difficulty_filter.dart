import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/extensions/styled_recipe_difficulty.dart';
import 'package:flutter/material.dart';

class RecipeSearchDifficultyFilter extends StatefulWidget {
  const RecipeSearchDifficultyFilter({super.key, required this.difficulties});

  final List<RecipeDifficulty> difficulties;

  @override
  State<RecipeSearchDifficultyFilter> createState() =>
      _RecipeSearchDifficultyFilterState();
}

class _RecipeSearchDifficultyFilterState
    extends State<RecipeSearchDifficultyFilter> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8.0,
      spacing: 8.0,
      children: RecipeDifficulty.values.map((difficulty) {
        final isSelected = widget.difficulties.contains(difficulty);
        return _Difficulty(
          difficulty: difficulty,
          toggle: (difficulty) {
            setState(() {
              if (widget.difficulties.contains(difficulty)) {
                widget.difficulties.remove(difficulty);
              } else {
                widget.difficulties.add(difficulty);
              }
            });
          },
          isSelected: isSelected,
        );
      }).toList(),
    );
  }
}

class _Difficulty extends StatelessWidget {
  const _Difficulty({
    required this.difficulty,
    required this.toggle,
    required this.isSelected,
  });

  final void Function(RecipeDifficulty) toggle;
  final bool isSelected;
  final RecipeDifficulty difficulty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggle(difficulty);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const .symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isSelected ? difficulty.color() : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : difficulty.color(),
          ),
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
      ),
    );
  }
}
