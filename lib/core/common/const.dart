import 'package:flutter/material.dart';

class AppConstants {

  //app
  static const double bottomNavigationHeight = 65;

  //routes
  static const String homeRoute = '/';
  static const String addNoteRoute = '/add_note';
  static const String editNoteRoute = '/edit_note';

  //shared prefs
  static const String isFirstRun = 'first_time';
  static const String darkMode = 'darkMode';
  static const String isWeb = 'isWeb';
  static const String appLanguage = 'appLang';

  //URLs
  static const String githubUrl =
      'https://github.com/yalda-student/student_note';
  static const String linkedInUrl =
      'https://www.linkedin.com/in/yalda-mohasseli-270049178/';

}

extension GlobalBuildContextExt on BuildContext{

  bool isDesktop(){
    return Theme.of(this).platform == TargetPlatform.linux ||
        Theme.of(this).platform == TargetPlatform.macOS ||
        Theme.of(this).platform == TargetPlatform.windows;
  }

}
