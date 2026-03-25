import 'package:cookify/config/constant/app_constant.dart';
import 'package:cookify/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData _data(AppPalette palette) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: palette.primary(),
      brightness: palette.brightness(),
      primary: palette.primary(),
      secondary: palette.secondary(),
      onSurface: palette.primary(),
    ),
    scaffoldBackgroundColor: palette.primary(),
    fontFamily: appFontFamily,
    iconTheme: IconThemeData(color: palette.primary()),
    appBarTheme: AppBarTheme(
      backgroundColor: palette.primary(),
      foregroundColor: palette.secondary(),
      surfaceTintColor: palette.primary(),
    ),
  );

  static ThemeData light() => _data(AppPaletteLight());

  static ThemeData dark() => _data(AppPaletteDark());
}
