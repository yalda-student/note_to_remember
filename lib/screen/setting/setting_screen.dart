import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/util/theme_util.dart';

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
            AppBar(
              title: Text(
                LocaleKeys.setting.tr(),
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
              leading: const Icon(Iconsax.setting),
            ),
            const Divider(),
            ListTile(
              title: const Text(LocaleKeys.theme).tr(),
              trailing: SizedBox(
                width: 60,
                height: 50,
                child: DayNightSwitcher(
                  isDarkModeEnabled: _enableDarkTheme,
                  sunColor: Colors.amber,
                  onStateChanged: (val) {
                    debugPrint('onStateChanged: $val');
                    setState(() {
                      _enableDarkTheme = val;
                    });
                    onThemeChanged(val, themeNotifier);
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text(LocaleKeys.language).tr(),
              trailing: SizedBox(
                width: 151,
                height: 40,
                child: ToggleSwitch(
                  minWidth: 75.0,
                  cornerRadius: 20.0,
                  activeBgColors: [
                    [theme.colorScheme.secondary],
                    [theme.colorScheme.secondary]
                  ],
                  activeFgColor: theme.colorScheme.surface,
                  inactiveBgColor: theme.colorScheme.surface,
                  inactiveFgColor: theme.colorScheme.onPrimary,
                  initialLabelIndex:
                      EasyLocalization.of(context)!.currentLocale ==
                              const Locale('en', 'US')
                          ? 0
                          : 1,
                  totalSwitches: 2,
                  labels: const ['English', 'فارسی'],
                  curve: Curves.linear,
                  customTextStyles: [
                    theme.textTheme.subtitle1!
                        .copyWith(color: const Color(0xff6996ea), fontSize: 13),
                    theme.textTheme.subtitle1!
                        .copyWith(color: const Color(0xff6996ea), fontSize: 13)
                  ],
                  radiusStyle: true,
                  animate: true,
                  onToggle: (index) => onLanguageChange(index!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  void onLanguageChange(int index) async {
    final prefs = await SharedPreferences.getInstance();
    if (index == 0) {
      await context.setLocale(const Locale('en', 'US'));
      prefs.setString('appLang', const Locale('en', 'US').languageCode);
    } else {
      await context.setLocale(const Locale('fa', 'IR'));
      prefs.setString('appLang', const Locale('fa', 'IR').languageCode);
    }
  }
}
