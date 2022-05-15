import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalda_students_notes/core/common/const.dart';

class SharedPref {
  static late SharedPreferences pref;
  static Future<void> initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  static setLanguage(String languageCode){
    pref.setString(AppConstants.appLanguage, languageCode);
  }

  static String getLanguage(){
    return pref.getString(AppConstants.appLanguage) ?? "";
  }

}