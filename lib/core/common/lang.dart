import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/data/datasource/shared_pref.dart';

Future<String?> getLanguageCode() async {
  String? code = SharedPref.pref.getString('appLang');
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
    if (locale == const Locale('en', 'US')) {
      SharedPref.pref.setString(
          AppConstants.appLanguage, const Locale('en', 'US').languageCode);
    } else {
      SharedPref.pref.setString(
          AppConstants.appLanguage, const Locale('fa', 'IR').languageCode);
    }
  }
}
