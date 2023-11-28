import "package:flutter/material.dart";

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
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontFamily: "Ubuntu",
      fontStyle:  FontStyle.normal,
      color:      Color(0xFFEDE6D6),
      fontSize:   16
    ),
    titleMedium: TextStyle(
      fontFamily: "Ubuntu",
      fontStyle:  FontStyle.normal,
      color:      Color(0xFFEDE6D6),
      fontSize:   20
    )
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
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontFamily: "Ubuntu",
      fontStyle:  FontStyle.normal,
      color:      Color(0xFF181818),
      fontSize:   16
    ),
    titleMedium: TextStyle(
      fontFamily: "Ubuntu",
      fontStyle:  FontStyle.normal,
      color:      Color(0xFF181818),
      fontSize:   20
    )
  )
);