import 'package:flutter/material.dart';

sealed class AppPalette {
  Brightness brightness();

  Color primary();

  Color secondary();

  static final Color text = Color(0xFF120A08);

  static final Color error = Color(0xFF83260E);

  static final Color recipeDifficultyEasy = Color(0xFF7FB069);
  static final Color recipeDifficultyMedium = Color(0xFFE8B86D);
  static final Color recipeDifficultyHard = Color(0xFFE76F51);
}

class AppPaletteLight extends AppPalette {
  @override
  Brightness brightness() => Brightness.light;
  
  @override
  Color primary() => Color(0xFF120A08);
  
  @override
  Color secondary() => Color(0xFF2C1C16);
}

class AppPaletteDark extends AppPalette {
  @override
  Brightness brightness() => Brightness.dark;
  
  @override
  Color primary() => Color(0xFF120A08);
  
  @override
  Color secondary() => Color(0xFF2C1C16);
}
