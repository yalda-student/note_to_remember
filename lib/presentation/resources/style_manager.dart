import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';

class StyleManager {
  static TextStyle drawerTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveValue(
        context,
        defaultValue: 15.0,
        valueWhen: const [
          Condition.equals(name: TABLET, value: 12.0),
        ],
      ).value,
    );
  }

  static TextStyle tabBarTextStyle(BuildContext context) {
    var isEn =
        EasyLocalization.of(context)!.currentLocale == const Locale('en', 'US');
    return Theme.of(context)
        .textTheme
        .bodyText1!
        .apply(fontSizeDelta: isEn ? 0.0 : -4.0);
  }

  static TextStyle headerTextStyle(BuildContext context) {
    var isEn =
        EasyLocalization.of(context)!.currentLocale == const Locale('en', 'US');
    return Theme.of(context)
        .textTheme
        .headline6!
        .apply(fontSizeDelta: isEn ? -2.0 : -5.0, fontWeightDelta: 5);
  }

  static TextStyle noteTitleTextStyle(ThemeData theme) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w800,
        fontSize: 18,
        color: theme.colorScheme.onSurface.withOpacity(0.85));
  }

  static TextStyle noteContentTextStyle(ThemeData theme) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: theme.colorScheme.onSurface.withOpacity(0.7));
  }

  static TextStyle noteCategoryTextStyle(ThemeData theme) {
    return TextStyle(
        overflow: TextOverflow.ellipsis,
        fontWeight: FontWeight.w400,
        fontSize: 10,
        color: theme.colorScheme.onSurface);
  }

  static TextStyle counterTextStyle(ThemeData theme) =>
      TextStyle(color: ColorManager.getNoteEditorTextColor(theme));

  static TextStyle dialogTitlePersianDarkTextStyle() => const TextStyle(
      fontFamily: FontConstants.iranMarkerFont,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white);

  static TextStyle dialogTitlePersianLightTextStyle() => const TextStyle(
      fontSize: 16,
      fontFamily: FontConstants.iranMarkerFont,
      fontWeight: FontWeight.w500,
      color: ColorManager.primaryDark);

  static TextStyle dialogTitleEnglishDarkTextStyle() => const TextStyle(
      fontFamily: FontConstants.icFont,
      fontSize: FontSize.s18,
      fontWeight: FontWeight.w600,
      color: Colors.white);

  static TextStyle dialogTitleEnglishLightTextStyle() => const TextStyle(
      fontFamily: FontConstants.icFont,
      fontSize: FontSize.s18,
      fontWeight: FontWeight.w600,
      color: ColorManager.primaryDark);
}
