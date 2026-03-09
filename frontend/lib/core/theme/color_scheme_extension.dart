import 'package:flutter/material.dart';

class ColorSchemeExtension extends ThemeExtension<ColorSchemeExtension> {
  ColorSchemeExtension({required this.primaryLight});

  final Color primaryLight;

  @override
  ColorSchemeExtension copyWith({Color? primaryLight}) {
    return ColorSchemeExtension(
      primaryLight: primaryLight ?? this.primaryLight,
    );
  }

  @override
  ColorSchemeExtension lerp(
    ThemeExtension<ColorSchemeExtension>? other,
    double t,
  ) {
    if (other is! ColorSchemeExtension) {
      return this;
    }
    return ColorSchemeExtension(
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
    );
  }
}
