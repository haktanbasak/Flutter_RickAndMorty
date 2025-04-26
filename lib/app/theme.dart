import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  ThemeData get theme => themeMode == ThemeMode.light ? lightTheme : darkTheme;

  void toogleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

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

  static ThemeData get darkTheme => ThemeData(
    fontFamily: "Inter",
    scaffoldBackgroundColor: Color(0xFF414A4C),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF97C3E9),
      secondary: Color(0xFF778899),
      surface: Color(0xFF414A4C),
      onSurface: Colors.white,
      error: Color(0xFFEA7979),
      tertiary: Color(0xFFB5C4C7),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: Color(0xFF42B4CA)),
    ),
  );
}
