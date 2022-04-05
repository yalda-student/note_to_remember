import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColor {}

class AppConstants {
  static const String homeRoute = '/';
  static const String addNoteRoute = '/add_note';
  static const String editNoteRoute = '/edit_note';
}

Map<Locale, String> languagesMap = {
  const Locale('en', 'US'): "English",
  const Locale('fa', 'IR'): "فارسی",
};

Future<String?> getLanguageCode() async {
  final prefs = await SharedPreferences.getInstance();
  String? code = prefs.getString('appLang');
  return code;
}

