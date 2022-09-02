import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app/app_prefs.dart';
import 'package:yalda_students_notes/app/di.dart';
import 'package:yalda_students_notes/presentation/util/theme_util.dart';

extension BuildContextExts on BuildContext {
  bool screenIsHorizontal() {
    if (MediaQuery.of(this).size.width < MediaQuery.of(this).size.height) {
      //use horizontal |
      return true;
    } else {
      //use vertical __
      return false;
    }
  }

  void changeTheme(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    final appPref = instance<AppPreferences>();
    await appPref.setTheme(value);
  }

  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;
}

extension StringExts on String {
  bool isLanguageRtl() {
    return this == (const Locale('fa', 'IR').languageCode);
  }
}
