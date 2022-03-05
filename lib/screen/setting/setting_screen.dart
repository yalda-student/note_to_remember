import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                'Setting',
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
              leading: const Icon(Iconsax.setting),
            ),
            const Divider(),
            ListTile(
              title: const Text('Dark mode'),
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
}
