import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app/global.dart';

class LanguageNotifier with ChangeNotifier {
  Locale locale;

  LanguageNotifier(this.locale);

  Locale getLocale() => locale;

  void setLocale(Locale newLocale) {
    locale = newLocale;
    appLocale = newLocale;
    notifyListeners();
  }
}
