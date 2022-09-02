import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app/app.dart';
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
   return getTheme().brightness == Brightness.dark;
 }
}

ThemeData get lightTheme {
  final isPersian = isPersianLanguage();
  return ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: isPersian ? FontConstants.iranMarkerFont : FontConstants.icFont,
    radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(ColorManager.radioButtonColor)),
    dividerColor: Colors.grey,
    errorColor: const Color(0xffE01921),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: AppSize.s0,
      color: Colors.white,
      iconTheme: IconThemeData(color: ColorManager.primaryDark),
      titleTextStyle: TextStyle(
          color: Color(0xff293241),
          fontWeight: FontWeight.bold,
          fontSize: FontSize.s20),
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
    inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        counterStyle: TextStyle(
          color: ColorManager.primaryDark,
          fontFamily:
              isPersian ? FontConstants.iranMarkerFont : FontConstants.icFont,
        )),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: isPersian
          ? StyleManager.dialogTitlePersianLightTextStyle()
          : StyleManager.dialogTitleEnglishLightTextStyle(),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
    ),
  );
}

ThemeData get darkTheme {
  final isPersian = isPersianLanguage();
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: isPersian ? FontConstants.iranMarkerFont : FontConstants.icFont,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    dividerColor: Colors.grey,
    errorColor: const Color(0xffFF4545),
    scaffoldBackgroundColor: ColorManager.primaryDark,
    appBarTheme: AppBarTheme(
      color: ColorManager.primaryDark,
      elevation: AppSize.s0,
      titleTextStyle: TextStyle(
          fontFamily:
              isPersian ? FontConstants.iranMarkerFont : FontConstants.icFont,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: FontSize.s20),
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
    inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        counterStyle: TextStyle(
          color: ColorManager.tabBarDarkColor,
          fontFamily:
              isPersian ? FontConstants.iranMarkerFont : FontConstants.icFont,
        )),
    dialogTheme: DialogTheme(
      titleTextStyle: isPersian
          ? StyleManager.dialogTitlePersianDarkTextStyle()
          : StyleManager.dialogTitleEnglishDarkTextStyle(),
      backgroundColor: ColorManager.bottomNavigationDarkColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s12))),
    ),
  );
}
