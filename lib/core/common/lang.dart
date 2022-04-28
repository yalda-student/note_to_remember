import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalda_students_notes/core/common/const.dart';

Future<String?> getLanguageCode() async {
  final prefs = await SharedPreferences.getInstance();
  String? code = prefs.getString('appLang');
  return code;
}

Map<Locale, String> languagesMap = {
  const Locale('en', 'US'): "English",
  const Locale('fa', 'IR'): "فارسی",
};

List<String> languagesList = ['English', 'فارسی'];

mixin AppLanguage {
  void onLanguageChange(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    if (locale == const Locale('en', 'US')) {
      prefs.setString(
          AppConstants.appLanguage, const Locale('en', 'US').languageCode);
    } else {
      prefs.setString(
          AppConstants.appLanguage, const Locale('fa', 'IR').languageCode);
    }
  }
}
