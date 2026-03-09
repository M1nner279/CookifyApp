import 'package:cookify/core/theme/color_scheme_extension.dart';
import 'package:flutter/material.dart';

abstract class T {
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color primaryLight(BuildContext context) =>
      Theme.of(context).extension<ColorSchemeExtension>()!.primaryLight;

  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Gradient primaryGradient(BuildContext context) => LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [T.primary(context), T.primaryLight(context)],
  );

  static TextStyle headlineLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge!;

  static TextStyle headlineMedium(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!;

  static TextStyle headlineSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall!;

  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!;

  static TextStyle titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!;

  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!;

  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;

  static TextStyle labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge!;

  static TextStyle labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!;

  static TextStyle labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall!;
}
