import 'package:flutter/material.dart';

const Color _primaryDarkColor = Color(0xFF181818);
const Color _primaryLightColor = Color(0xFFEDE6D6);

TextStyle _textStyle(
  bool isDarkMode, {
  required double fontSize,
  FontWeight fontWeight = FontWeight.normal,
  FontStyle fontStyle = FontStyle.normal,
}) =>
    TextStyle(
      color: isDarkMode ? _primaryLightColor : _primaryDarkColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );

ThemeData createTheme(bool isDarkMode) => ThemeData(
      colorScheme: ColorScheme(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primary: isDarkMode ? _primaryDarkColor : _primaryLightColor,
        onPrimary: isDarkMode ? _primaryLightColor : _primaryDarkColor,
        error: Colors.red,
        onError: isDarkMode ? _primaryDarkColor : _primaryLightColor,
        // Unused
        secondary: isDarkMode ? _primaryDarkColor : _primaryLightColor,
        onSecondary: isDarkMode ? _primaryLightColor : _primaryDarkColor,
        background: isDarkMode ? _primaryDarkColor : _primaryLightColor,
        onBackground: isDarkMode ? _primaryLightColor : _primaryDarkColor,
        surface: isDarkMode ? _primaryDarkColor : _primaryLightColor,
        onSurface: isDarkMode ? _primaryLightColor : _primaryDarkColor,
      ),
      textTheme: TextTheme(
        // Bolded
        titleSmall: _textStyle(isDarkMode, fontSize: 16, fontWeight: FontWeight.bold),
        titleMedium: _textStyle(isDarkMode, fontSize: 20, fontWeight: FontWeight.bold),
        titleLarge: _textStyle(isDarkMode, fontSize: 24, fontWeight: FontWeight.bold),
        // Italicized
        headlineSmall: _textStyle(isDarkMode, fontSize: 16, fontStyle: FontStyle.italic),
        headlineMedium: _textStyle(isDarkMode, fontSize: 20, fontStyle: FontStyle.italic),
        headlineLarge: _textStyle(isDarkMode, fontSize: 24, fontStyle: FontStyle.italic),
        // Normal
        bodySmall: _textStyle(isDarkMode, fontSize: 16),
        bodyMedium: _textStyle(isDarkMode, fontSize: 20),
        bodyLarge: _textStyle(isDarkMode, fontSize: 24),
      ),
    );
