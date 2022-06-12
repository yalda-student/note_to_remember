import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:yalda_students_notes/app/extensions.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/language_manager.dart';
import 'package:yalda_students_notes/presentation/screen/about/about_screen.dart';
import 'package:yalda_students_notes/presentation/util/theme_util.dart';



class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var _enableDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _enableDarkTheme = (themeNotifier.getTheme() == darkTheme);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
                title: Text(LocaleKeys.setting.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                leading:
                    Icon(Iconsax.setting, color: theme.colorScheme.secondary)),
            const Divider(),
            ListTile(
              title: const Text(LocaleKeys.theme).tr(),
              trailing: SizedBox(
                width: 60,
                height: 50,
                child: DayNightSwitcher(
                  isDarkModeEnabled: _enableDarkTheme,
                  sunColor: Colors.amber,
                  onStateChanged: (val) =>
                      context.changeTheme(val, themeNotifier),
                ),
              ),
            ),
            ListTile(
              title: const Text(LocaleKeys.language).tr(),
              trailing: const SizedBox(
                width: 151,
                height: 40,
                child: _LanguageSwitcher(),
              ),
            ),
            ListTile(
              title: const Text(LocaleKeys.about).tr(),
              trailing: IconButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ));
                  }),
                  icon: Icon(
                      EasyLocalization.of(context)!.currentLocale ==
                              const Locale('en', 'US')
                          ? Iconsax.arrow_circle_right
                          : Iconsax.arrow_circle_left,
                      color: theme.colorScheme.secondary)),
            )
          ],
        ),
      ),
    );
  }
}

class _LanguageSwitcher extends StatelessWidget with AppLanguage {
  const _LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ToggleSwitch(
      minWidth: 75.0,
      cornerRadius: 20.0,
      activeBgColors: [
        [theme.colorScheme.onSurface],
        [theme.colorScheme.onSurface]
      ],
      activeFgColor: theme.colorScheme.surface,
      inactiveBgColor: theme.colorScheme.surface,
      inactiveFgColor: theme.colorScheme.onPrimary,
      initialLabelIndex: EasyLocalization.of(context)!.currentLocale ==
              const Locale('en', 'US')
          ? 0
          : 1,
      totalSwitches: 2,
      labels: const ['English', 'فارسی'],
      curve: Curves.linear,
      customTextStyles: [
        theme.textTheme.subtitle1!
            .copyWith(color: ColorManager.radioButtonColor, fontSize: 13),
        theme.textTheme.subtitle1!
            .copyWith(color: ColorManager.radioButtonColor, fontSize: 13)
      ],
      radiusStyle: true,
      animate: true,
      onToggle: (index) {
        if (index == 0) {
          onLanguageChange(context, const Locale('en', 'US'));
        } else {
          onLanguageChange(context, const Locale('fa', 'IR'));
        }
      },
    );
  }
}
