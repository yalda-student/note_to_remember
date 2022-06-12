import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app/app_prefs.dart';
import 'package:yalda_students_notes/app/di.dart';

mixin AppLanguage {
  void onLanguageChange(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    final appPref = instance<AppPreferences>();

    if (locale == const Locale('en', 'US')) {
      appPref.setLanguage(const Locale('en', 'US').languageCode);
    } else {
      appPref.setLanguage(const Locale('fa', 'IR').languageCode);
    }
  }
}

Future<String> getLanguageCode() async {
  final appPref = instance<AppPreferences>();
  return await appPref.getLanguage();
}

Map<Locale, String> languagesMap = {
  const Locale('en', 'US'): "English",
  const Locale('fa', 'IR'): "فارسی",
};

List<String> languagesList = ['English', 'فارسی'];
