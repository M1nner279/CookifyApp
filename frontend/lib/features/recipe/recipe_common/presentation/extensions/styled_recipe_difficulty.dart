import 'package:cookify/features/recipe/recipe_common/domain/enums/recipe_difficulty.dart';
import 'package:flutter/material.dart';

extension StyledRecipeDifficulty on RecipeDifficulty {
  String text(BuildContext context) => switch (this) {
    RecipeDifficulty.easy => 'ЛЕГКО',
    RecipeDifficulty.medium => 'СРЕДНЕ',
    RecipeDifficulty.hard => 'СЛОЖНО',
  };

  Color color() => switch (this) {
    RecipeDifficulty.easy => const Color(0xFF7FB069),
    RecipeDifficulty.medium => const Color(0xFFE8B86D),
    RecipeDifficulty.hard => const Color(0xFFE76F51),
  };
}
