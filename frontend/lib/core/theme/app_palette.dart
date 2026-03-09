import 'package:flutter/material.dart';

sealed class AppPalette {
  Brightness brightness();

  Color primary();

  Color secondary();

  Color primaryLight();

  static final Color text = Color(0xFF000000);

  static final Color recipeDifficultyEasy = Colors.green.shade300;
  static final Color recipeDifficultyMedium = Colors.orange.shade300;
  static final Color recipeDifficultyHard = Colors.red.shade300;
}

class AppPaletteLight extends AppPalette {
  @override
  Brightness brightness() => Brightness.light;
  
  @override
  Color primary() => Color(0xFFD9AD74);
  
  @override
  Color secondary() => Color(0xFF2E2005);

  @override
  Color primaryLight() => Color(0xFFD4B896);
}

class AppPaletteDark extends AppPalette {
  @override
  Brightness brightness() => Brightness.dark;
  
  @override
  Color primary() => Color(0xFFD9AD74);
  
  @override
  Color secondary() => Color(0xFF2E2005);

  @override
  Color primaryLight() => Color(0xFFD4B896);
}
