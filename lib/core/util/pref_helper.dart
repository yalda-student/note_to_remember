
import 'package:shared_preferences/shared_preferences.dart';

import '../common/const.dart';

class PrefHelper{
  static late SharedPreferences prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
  static setIsWeb(bool value){
    prefs.setBool(AppConstants.isWeb, value);
  }
  static bool? getIsWeb(){
    return prefs.getBool(AppConstants.isWeb);
  }
}