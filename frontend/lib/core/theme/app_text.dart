import 'package:flutter/material.dart';

abstract class AppText {
  static TextTheme textTheme(Color color) => TextTheme(
    headlineLarge: TextStyle(
      color: color,
      fontSize: 28,
      fontWeight: FontWeight.w700,  
    ),
    headlineMedium: TextStyle(
      color: color,
      fontSize: 26,
      fontWeight: FontWeight.w700,  
    ),
    headlineSmall: TextStyle(
      color: color,
      fontSize: 24,
      fontWeight: FontWeight.w700,  
    ),
    titleLarge: TextStyle(
      color: color,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    titleMedium: TextStyle(
      color: color,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodySmall: TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    labelMedium: TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    labelSmall: TextStyle(
      color: color,
      fontSize: 10,
      fontWeight: FontWeight.w300,
    ),
  );
}
