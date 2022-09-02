import 'package:easy_localization/easy_localization.dart';
import 'package:shamsi_date/shamsi_date.dart';

String convertToJalaliDate(DateTime date){
  Jalali g2j1 = Gregorian.fromDateTime(date).toJalali();
  final jalaliDate = DateTime(g2j1.year, g2j1.month, g2j1.day);
 return DateFormat('yyyy/MM/dd').format(jalaliDate);
}