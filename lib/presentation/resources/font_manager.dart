import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class FontManager {

  static const String iranMarkerFont = 'IRANMarker';
  static const String icFont = 'ic_font';

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

  static TextStyle noteTitleTextStyle(ThemeData theme) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w800,
        fontSize: 18,
        color: theme.colorScheme.onSurface);
  }

  static TextStyle noteContentTextStyle(ThemeData theme) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: theme.colorScheme.onSurface);
  }

  static TextStyle noteCategoryTextStyle(ThemeData theme) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400,
        fontSize: 10,
        color: theme.colorScheme.onSurface);
  }
}
