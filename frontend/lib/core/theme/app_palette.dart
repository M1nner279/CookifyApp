import 'package:flutter/material.dart';

sealed class AppPalette {
  Brightness brightness();

  Color primary();

  Color secondary();

  Color tertiary();
}

class AppPaletteLight implements AppPalette {
  @override
  Brightness brightness() => Brightness.light;
  
  @override
  Color primary() => Color(0xffffffff);
  
  @override
  Color secondary() => Color(0xff121212);
  
  @override
  Color tertiary() => Color(0xfff5f5f5);
}

class AppPaletteDark implements AppPalette {
  @override
  Brightness brightness() => Brightness.dark;
  
  @override
  Color primary() => Color(0xff121212);
  
  @override
  Color secondary() => Color(0xffffffff);
  
  @override
  Color tertiary() => Color(0xff1E1E1E);
}
