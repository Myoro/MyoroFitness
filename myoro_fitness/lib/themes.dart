import "package:flutter/material.dart";

TextStyle _normal({ required Color color, required double fontSize }) => TextStyle(
  fontFamily: "Ubuntu",
  fontStyle:  FontStyle.normal,
  color:      color,
  fontSize:   fontSize
);

TextStyle _bold({ required Color color, required double fontSize }) => TextStyle(
  fontFamily: "Ubuntu",
  fontWeight: FontWeight.bold,
  color:      color,
  fontSize:   fontSize
);

final ThemeData dark = ThemeData(
  colorScheme: const ColorScheme(
    brightness:   Brightness.dark,
    primary:      Color(0xFF181818),
    onPrimary:    Color(0xFFEDE6D6),
    secondary:    Color(0xFF181818),
    onSecondary:  Color(0xFFEDE6D6),
    error:        Colors.red,
    onError:      Colors.white,
    background:   Color(0xFF181818),
    onBackground: Color(0xFFEDE6D6),
    surface:      Color(0xFF181818),
    onSurface:    Color(0xFFEDE6D6)
  ),
  textTheme: TextTheme(
    bodyMedium:  _normal(color: const Color(0xFFEDE6D6), fontSize: 16),
    bodySmall:   _normal(color: const Color(0xFFEDE6D6), fontSize: 12),
    titleLarge:  _normal(color: const Color(0xFFEDE6D6), fontSize: 24),
    titleMedium: _normal(color: const Color(0xFFEDE6D6), fontSize: 20),
    labelLarge:  _bold(color: const Color(0xFFEDE6D6), fontSize: 24),
    labelMedium: _bold(color: const Color(0xFFEDE6D6), fontSize: 16)
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor:    const Color(0xFFEDE6D6),
    selectionColor: const Color(0xFFEDE6D6).withOpacity(0.2)
  )
);

final ThemeData light = ThemeData(
  colorScheme: const ColorScheme(
    brightness:   Brightness.light,
    primary:      Color(0xFFEDE6D6),
    onPrimary:    Color(0xFF181818),
    secondary:    Color(0xFFEDE6D6),
    onSecondary:  Color(0xFF181818),
    error:        Colors.red,
    onError:      Colors.white,
    background:   Color(0xFFEDE6D6),
    onBackground: Color(0xFF181818),
    surface:      Color(0xFFEDE6D6),
    onSurface:    Color(0xFF181818)
  ),
  textTheme: TextTheme(
    bodyMedium:  _normal(color: const Color(0xFF181818), fontSize: 16),
    bodySmall:   _normal(color: const Color(0xFF181818), fontSize: 12),
    titleLarge:  _normal(color: const Color(0xFF181818), fontSize: 24),
    titleMedium: _normal(color: const Color(0xFF181818), fontSize: 20),
    labelLarge:  _bold(color: const Color(0xFF181818), fontSize: 16),
    labelMedium: _bold(color: const Color(0xFF181818), fontSize: 16)
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor:    const Color(0xFF181818),
    selectionColor: const Color(0xFF181818).withOpacity(0.2)
  )

);