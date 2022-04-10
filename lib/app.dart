import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColor {}

class AppConstants {
  static const String homeRoute = '/';
  static const String addNoteRoute = '/add_note';
  static const String editNoteRoute = '/edit_note';

  static const String isFirstRun = 'isFirstRun';
}

Map<Locale, String> languagesMap = {
  const Locale('en', 'US'): "English",
  const Locale('fa', 'IR'): "فارسی",
};

List<Color> categoryColors = [
  Colors.yellow,
  Colors.deepPurple,
  Colors.cyan,
  Colors.orange,
  Colors.lightGreen,
  Colors.red,
  Colors.indigo,
  Colors.teal,
];

Future<String?> getLanguageCode() async {
  final prefs = await SharedPreferences.getInstance();
  String? code = prefs.getString('appLang');
  return code;
}
