import 'package:flutter/cupertino.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';

class FontManager {
  static TextStyle drawerTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 15.0,
        valueWhen: const [
          Condition.largerThan(name: MOBILE, value: 15.0),
        ],
      ).value,
    );
  }

  static TextStyle noteTitleTextStyle() {
    return const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w800,
        fontSize: 18,
        color: ColorManager.primaryDark);
  }
  static TextStyle noteContentTextStyle() {
    return const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: ColorManager.primaryDark);
  }
}
