import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  ThemeData getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'ic_font',
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(color: Color(0xff010101)),
    titleTextStyle: TextStyle(
        color: Color(0xff293241),
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'ic_font'),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    primaryContainer: const Color(0xffe8ebed),
    onPrimary: Colors.grey.shade800,
    surface: Colors.grey.shade400,
    secondary: const Color(0xff010101),
  ),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Color(0xffc6c8ce),
      selectionHandleColor: Color(0xff626362)),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(8.0),
  ),
);

final darkTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  dividerColor: Colors.grey.shade400,
  fontFamily: 'ic_font',
  scaffoldBackgroundColor: const Color(0xff010101),
  appBarTheme: const AppBarTheme(
    color: Color(0xff010101),
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'ic_font'),
  ),
  colorScheme: ColorScheme.dark(
    primary: const Color(0xff010101),
    secondary: Colors.white,
    onPrimary: Colors.black54,
    surface: Colors.grey.shade400,
    primaryContainer: const Color(0xffe8ebed),
  ),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Color(0xffc6c8ce),
      selectionHandleColor: Color(0xff626362)),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(8.0),
  ),
);
