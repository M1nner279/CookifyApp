import 'package:cookify/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

abstract class AppText {
  static final TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      color: AppPalette.text,
      fontSize: 28,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      color: AppPalette.text,
      fontSize: 26,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      color: AppPalette.text,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      color: AppPalette.text,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: AppPalette.text,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      color: AppPalette.text,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      color: AppPalette.text,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: AppPalette.text,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      color: AppPalette.text,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      color: AppPalette.text,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    labelMedium: TextStyle(
      color: AppPalette.text,
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    labelSmall: TextStyle(
      color: AppPalette.text,
      fontSize: 10,
      fontWeight: FontWeight.w300,
    ),
  );
}
