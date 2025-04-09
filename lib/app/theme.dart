import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); // Private constructor - dışarıdan new AppTheme() yapamasın diye
  static ThemeData get lightTheme => ThemeData(
    fontFamily: "Inter",
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF42B4CA),
      secondary: Color(0xFFD5E9ED),
      surface: Colors.white,
      onSurface: Color(0xFF414A4C),
      error: Color(0xFFEA7979),
      tertiary: Color(0xFFB5C4C7),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Color(0xFF42B4CA)),
    ),
  );
}
