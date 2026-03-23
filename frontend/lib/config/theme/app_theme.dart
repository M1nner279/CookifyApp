import 'package:cookify/config/theme/app_palette.dart';
import 'package:cookify/config/theme/app_text.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData _data(AppPalette palette) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: palette.primary(),
      brightness: palette.brightness(),
      primary: palette.primary(),
      secondary: palette.secondary(),
    ),
    scaffoldBackgroundColor: palette.secondary(),
    fontFamily: 'PlusJakartaSans',
    iconTheme: IconThemeData(color: palette.secondary()),
    textTheme: AppText.textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: palette.secondary(),
      foregroundColor: palette.primary(),
      surfaceTintColor: palette.secondary(),
    ),
  );

  static ThemeData light() => _data(AppPaletteLight());

  static ThemeData dark() => _data(AppPaletteDark());
}
