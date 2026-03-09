import 'package:cookify/core/l10n/s.dart';
import 'package:cookify/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

enum RecipeDifficulty {
  easy,
  medium,
  hard;

  String text(BuildContext context) => switch (this) {
    RecipeDifficulty.easy => S.of(context).recipeDifficultyEasy,
    RecipeDifficulty.medium => S.of(context).recipeDifficultyMedium,
    RecipeDifficulty.hard => S.of(context).recipeDifficultyHard,
  };

  Color color() => switch (this) {
    RecipeDifficulty.easy => AppPalette.recipeDifficultyEasy,
    RecipeDifficulty.medium => AppPalette.recipeDifficultyMedium,
    RecipeDifficulty.hard => AppPalette.recipeDifficultyHard,
  };
}
