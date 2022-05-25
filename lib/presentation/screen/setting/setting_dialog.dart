import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/core/common/lang.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/core/common/util/theme_util.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/widgets/language_radio_button.dart';

AlertDialog settingDialog(BuildContext context, ThemeData theme) {
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  final _isDark = (themeNotifier.getTheme() == darkTheme);

  final appLanguage =
      EasyLocalization.of(context)!.currentLocale == const Locale('en', 'US');
  return AlertDialog(
    title: Text(LocaleKeys.setting.tr(),
        style: TextStyle(fontSize: FontSize.alertDialogTitle(context))),
    content: SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () => showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => languageDialog(context, theme),
            ),
            title: Text(
              LocaleKeys.language.tr(),
              style: TextStyle(fontSize: FontSize.alertDialogContent(context)),
            ),
            trailing: Text(
              appLanguage ? languagesList[0] : languagesList[1],
              style: TextStyle(
                  color: ColorManager.radioButtonColor,
                  fontSize: FontSize.alertDialogContent(context)),
            ),
          ),
          ListTile(
            title: Text(LocaleKeys.theme.tr(),
                style:
                    TextStyle(fontSize: FontSize.alertDialogContent(context))),
            trailing: Icon(
              _isDark ? Iconsax.moon5 : Iconsax.sun_15,
              color: _isDark ? Colors.white : Colors.amber,
              size: AppSize.iconSize(context),
            ),
            onTap: () => context.changeTheme(!_isDark, themeNotifier),
          ),
          SizedBox(height: context.screenHeight * 0.02),
          const Text(
            AppConstants.appVersion,
            style: TextStyle(
              fontSize: FontSize.s12,
              color: ColorManager.unselectedTabLabelDarkColor,
            ),
          ),
        ],
      ),
    ),
  );
}

AlertDialog languageDialog(BuildContext context, ThemeData theme) {
  return AlertDialog(
    title: Text(LocaleKeys.language.tr()),
    content: const LanguageRadioButton(),
    actions: [
      TextButton(
        child: Text(
          LocaleKeys.cancel.tr(),
          style: TextStyle(color: theme.colorScheme.secondary.withOpacity(0.7)),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );
}
