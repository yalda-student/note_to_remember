import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FontManager {
  static TextStyle drawerTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: const [
        Condition.largerThan(name: MOBILE, value: 15.0),
      ]).value,
    );
  }
}
