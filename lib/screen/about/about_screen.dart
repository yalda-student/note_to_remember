import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:yalda_students_notes/common/const.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    bool isLTR =
        EasyLocalization.of(context)!.currentLocale == const Locale('en', 'US');

    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.about).tr(),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
              EasyLocalization.of(context)!.currentLocale ==
                      const Locale('en', 'US')
                  ? Iconsax.arrow_circle_left
                  : Iconsax.arrow_circle_right,
              color: theme.colorScheme.secondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading:
                Icon(FeatherIcons.user, color: theme.colorScheme.secondary),
            title: Text('Yalda Student',
                style: TextStyle(
                    color: theme.colorScheme.secondary, fontSize: 16)),
          ),
          ListTile(
            leading:
                Icon(FeatherIcons.github, color: theme.colorScheme.secondary),
            title: TextButton(
                onPressed: () => _launchGithub(),
                child: Container(
                  alignment:
                      isLTR ? Alignment.centerLeft : Alignment.centerRight,
                  child: Text('Github',
                      style: TextStyle(
                          color: theme.colorScheme.secondary, fontSize: 16)),
                )),
          ),
          ListTile(
            leading: const Icon(FeatherIcons.linkedin, color: Colors.blue),
            title: Container(
              alignment: isLTR ? Alignment.centerLeft : Alignment.centerRight,
              child: TextButton(
                  onPressed: () => _launchLinkedIn(),
                  child: Text('Linkedin',
                      style: TextStyle(
                          color: theme.colorScheme.secondary, fontSize: 16))),
            ),
          ),
        ],
      ),
    );
  }

  void _launchGithub() async {
    try {
      await launch(AppConstants.githubUrl);
    } catch (e) {
      debugPrint("Could not launch ${AppConstants.githubUrl}");
    }
  }

  void _launchLinkedIn() async {
    try {
      await launch(AppConstants.linkedInUrl);
    } catch (e) {
      debugPrint("Could not launch ${AppConstants.githubUrl}");
    }
  }
}
