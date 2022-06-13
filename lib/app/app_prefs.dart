import 'package:shared_preferences/shared_preferences.dart';

const String firstRun = 'first_time';
const String darkMode = 'darkMode';
const String appLanguage = 'appLang';

class AppPreferences {
  final SharedPreferences _pref;

  AppPreferences(this._pref);

  Future<bool> setLanguage(String languageCode) async {
    return await _pref.setString(appLanguage, languageCode);
  }

  Future<String> getLanguage() async {
    return _pref.getString(appLanguage) ?? "";
  }

  Future<bool> setFirstRun(bool isFirstRun) async {
    return _pref.setBool(firstRun, isFirstRun);
  }

  Future<bool> isFirstRun() async {
    //check def value
    return _pref.getBool(firstRun) ?? true;
  }

  Future<bool> setTheme(bool isDark) async {
    return _pref.setBool(darkMode, isDark);
  }

  Future<bool> getTheme() async {
    //check def value
    return _pref.getBool(darkMode) ?? false;
  }
}
