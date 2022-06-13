import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalda_students_notes/app/app_prefs.dart';
import 'package:yalda_students_notes/app/const.dart';
import 'package:yalda_students_notes/app/di.dart';
import 'package:yalda_students_notes/app/extensions.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.about,
                style: theme.appBarTheme.titleTextStyle!.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontSize: FontSize.onBoardBody(context),
                    fontWeight: FontWeight.w600))
            .tr(),
        leading: IconButton(
          icon: Icon(
              EasyLocalization.of(context)!.currentLocale ==
                      const Locale('en', 'US')
                  ? Iconsax.arrow_circle_left
                  : Iconsax.arrow_circle_right,
              color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading:
                Icon(FeatherIcons.user, color: theme.colorScheme.onSurface),
            title: Text('Yalda Student',
                style: TextStyle(
                    color: theme.colorScheme.onSurface, fontSize: 16)),
          ),
          _AboutTile(
            onTap: () {},
            title: 'Yalda Student',
            icon: Icon(FeatherIcons.user, color: theme.colorScheme.onSurface),
          ),
          _AboutTile(
            onTap: _launchGithub,
            title: 'Github',
            icon: Icon(FeatherIcons.github, color: theme.colorScheme.onSurface),
          ),
          _AboutTile(
              onTap: _launchLinkedIn,
              title: 'Linkedin',
              icon: const Icon(FeatherIcons.linkedin, color: Colors.blue)),
        ],
      ),
    );
  }

  void _launchGithub() async {
    try {
      final Uri _url = Uri.parse(AppConstants.githubUrl);
      await launchUrl(_url);
    } catch (e) {
      debugPrint("Could not launch ${AppConstants.githubUrl}");
    }
  }

  void _launchLinkedIn() async {
    try {
      final Uri _url = Uri.parse(AppConstants.linkedInUrl);
      await launchUrl(_url);
    } catch (e) {
      debugPrint("Could not launch ${AppConstants.githubUrl}");
    }
  }
}

class _AboutTile extends StatelessWidget {
  final Function() onTap;
  final String title;
  final Widget icon;

  const _AboutTile(
      {Key? key, required this.onTap, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appPref = instance<AppPreferences>();
    return FutureBuilder<String>(
        future: appPref.getLanguage(),
        initialData: const Locale('en', 'US').languageCode,
        builder: (context, snapshot) {
          return ListTile(
            leading: icon,
            title: Container(
              alignment: snapshot.data!.isLanguageRtl()
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: TextButton(
                  onPressed: () => onTap,
                  child: Text(title,
                      style: TextStyle(
                          color: theme.colorScheme.onSurface, fontSize: 16))),
            ),
          );
        });
  }
}
