import 'package:flutter/material.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';

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
  dividerColor: Colors.grey,
  errorColor:const Color(0xffE01921),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(color: ColorManager.primaryDark),
    titleTextStyle: TextStyle(
        color: Color(0xff293241),
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'ic_font'),
  ),
  colorScheme: ColorScheme.light(
      primary: Colors.white,
      surface: Colors.grey.shade400,
      primaryContainer: ColorManager.lightGray,
      onPrimary: Colors.grey.shade800,
      secondary: ColorManager.unselectedTabLabelDarkColor,
      onSecondary: Colors.white,
      onSurface: ColorManager.primaryDark,
      onBackground: ColorManager.primaryDark),
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
  fontFamily: 'ic_font',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  dividerColor: Colors.grey,
  errorColor: const Color(0xffFF4545),
  scaffoldBackgroundColor: ColorManager.primaryDark,
  appBarTheme: const AppBarTheme(
    color: ColorManager.primaryDark,
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'ic_font'),
  ),
  colorScheme: const ColorScheme.dark(
      primary: ColorManager.primaryDark,
      secondary: Colors.white,
      onSurface: Colors.white,
      onPrimary: ColorManager.unselectedTabLabelDarkColor,
      surface: ColorManager.tabBarDarkColor,
      primaryContainer: ColorManager.lightGray,
      onSecondary: ColorManager.bottomNavigationDarkColor,
      onBackground: ColorManager.bottomNavigationDarkColor),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Color(0xffc6c8ce),
      selectionHandleColor: Color(0xff626362)),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(8.0),
  ),
);
