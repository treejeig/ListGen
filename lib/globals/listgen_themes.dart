import 'package:flutter/material.dart';

class ListGenThemes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF252525),
    primaryColor: Color(0xFF252525),
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.tealAccent),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade400,
    primaryColor: Colors.grey.shade400,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.black),
    cardColor: Colors.white54,
  );
}
