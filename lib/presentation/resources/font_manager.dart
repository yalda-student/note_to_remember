import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FontConstants {
  static const String icFont = 'ic_font';
  static const String iranMarkerFont = 'IRANMarker';
}

class FontSize {
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s19 = 19.0;
  static const double s20 = 20.0;

  static double alertDialogTitle(BuildContext context) =>
      ResponsiveValue<double>(context, defaultValue: s19, valueWhen: [
        const Condition.equals(name: TABLET, value: s17),
      ]).value!;

  static double alertDialogContent(BuildContext context) =>
      ResponsiveValue<double>(context, defaultValue: s16, valueWhen: [
        const Condition.equals(name: TABLET, value: s15),
      ]).value!;
}
