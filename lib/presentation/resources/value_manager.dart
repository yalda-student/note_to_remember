import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ValueManager {
  static const double gridSpacing = 20.0;
}

class AppPadding {
  static const double p0 = 0.0;
  static const double p4 = 4.0;
  static const double p6 = 6.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
}

class AppSize {
  static const double s0 = 0.0;
  static const double s6 = 6.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
  static const double s30 = 30.0;

  static double iconSize(BuildContext context) =>
      ResponsiveValue<double>(context, defaultValue: s22, valueWhen: [
        const Condition.equals(name: TABLET, value: s20),
      ]).value!;

  static double colorPickerIconSize(BuildContext context) =>
      ResponsiveValue<double>(context, defaultValue: s30, valueWhen: [
        const Condition.equals(name: TABLET, value: 24),
      ]).value!;

  static double checkIconSize(BuildContext context) =>
      ResponsiveValue<double>(context, defaultValue: s18, valueWhen: [
        const Condition.equals(name: TABLET, value: s15),
      ]).value!;
}
