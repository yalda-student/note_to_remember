import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/style_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  ThemeData getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  bool isDark() {
    return getTheme() == darkTheme;
  }
}

final lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily:
      isPersianLanguage() ? FontConstants.iranMarkerFont : FontConstants.icFont,
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(ColorManager.radioButtonColor)),
  dividerColor: Colors.grey,
  errorColor: const Color(0xffE01921),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: Colors.white,
    iconTheme: IconThemeData(color: ColorManager.primaryDark),
    titleTextStyle: TextStyle(
        color: Color(0xff293241), fontWeight: FontWeight.bold, fontSize: 20),
  ),
  colorScheme: ColorScheme.light(
      primary: Colors.white,
      secondary: ColorManager.unselectedTabLabelDarkColor,
      onSurface: ColorManager.primaryDark,
      onPrimary: Colors.grey.shade800,
      surface: Colors.grey.shade400,
      primaryContainer: ColorManager.lightGray,
      onSecondary: Colors.white,
      onBackground: ColorManager.primaryDark),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Color(0xffc6c8ce),
      selectionHandleColor: Color(0xff626362)),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(8.0),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: isPersianLanguage()
        ? StyleManager.dialogTitlePersianLightTextStyle()
        : StyleManager.dialogTitleEnglishLightTextStyle(),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
  ),
);

final darkTheme = ThemeData(
  fontFamily:
      isPersianLanguage() ? FontConstants.iranMarkerFont : FontConstants.icFont,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  dividerColor: Colors.grey,
  errorColor: const Color(0xffFF4545),
  scaffoldBackgroundColor: ColorManager.primaryDark,
  appBarTheme: AppBarTheme(
    color: ColorManager.primaryDark,
    elevation: 0,
    titleTextStyle: TextStyle(
        fontFamily: isPersianLanguage()
            ? FontConstants.iranMarkerFont
            : FontConstants.icFont,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20),
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
  radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(ColorManager.radioButtonColor)),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Color(0xffc6c8ce),
      selectionHandleColor: Color(0xff626362)),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(8.0),
  ),
  dialogTheme: DialogTheme(
    titleTextStyle: isPersianLanguage()
        ? StyleManager.dialogTitlePersianDarkTextStyle()
        : StyleManager.dialogTitleEnglishDarkTextStyle(),
    backgroundColor: ColorManager.bottomNavigationDarkColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
  ),
);
