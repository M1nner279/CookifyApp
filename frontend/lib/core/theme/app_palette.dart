import 'package:flutter/material.dart';

sealed class AppPalette {
  Brightness brightness();

  Color primary();

  Color secondary();

  Color primaryLight();

  Color text();
}

class AppPaletteLight implements AppPalette {
  @override
  Brightness brightness() => Brightness.light;
  
  @override
  Color primary() => Color(0xFFD9AD74);
  
  @override
  Color secondary() => Color(0xFF2E2005);

  @override
  Color primaryLight() => Color(0xFFD4B896);

  @override
  Color text() => Color(0xFF000000);
}

class AppPaletteDark implements AppPalette {
  @override
  Brightness brightness() => Brightness.dark;
  
  @override
  Color primary() => Color(0xFFD9AD74);
  
  @override
  Color secondary() => Color(0xFF2E2005);

  @override
  Color primaryLight() => Color(0xFFD4B896);

  @override
  Color text() => Color(0xFF000000);
}
