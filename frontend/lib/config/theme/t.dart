import 'package:cookify/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

abstract class T {
  static final light = AppTheme.light();
  static final dark = AppTheme.dark();

  static ThemeData of(BuildContext context) => Theme.of(context);
}
