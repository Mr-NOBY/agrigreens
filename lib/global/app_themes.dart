import 'package:flutter/material.dart';

class Themes {
  static ThemeData mainthemeData = ThemeData(
    colorScheme: maincolorScheme,
    textTheme: textcolorScheme,

    // useMaterial3: true,
  );
  static ThemeData darkthemeData = ThemeData(
    colorScheme: darkcolorScheme,
    textTheme: textcolorScheme,
  );

  static const ColorScheme maincolorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(17, 70, 60, 1),
    onPrimary: Color.fromRGBO(250, 199, 131, 1),
    secondary: Color.fromRGBO(17, 70, 60, 1),
    onSecondary: Color.fromRGBO(250, 199, 131, 1),
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Color.fromRGBO(17, 70, 60, 1),
  );
  static const TextTheme textcolorScheme = TextTheme(
    labelLarge: TextStyle(color: Color.fromRGBO(250, 199, 131, 1)),
    labelMedium: TextStyle(color: Color.fromRGBO(250, 199, 131, 1)),
    labelSmall: TextStyle(color: Color.fromRGBO(250, 199, 131, 1)),
  );
  static const ColorScheme darkcolorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(250, 199, 131, 1),
    onPrimary: Color.fromRGBO(17, 70, 60, 1),
    secondary: Color.fromRGBO(250, 199, 131, 1),
    onSecondary: Color.fromRGBO(17, 70, 60, 1),
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromRGBO(17, 70, 60, 1),
    onSurface: Color.fromRGBO(250, 199, 131, 1),
  );
}
