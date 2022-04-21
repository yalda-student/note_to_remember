import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:yalda_students_notes/common/const.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_circle_left,
              color: theme.colorScheme.secondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading:
                Icon(FeatherIcons.user, color: theme.colorScheme.secondary),
            title: const Text('Yalda Mohasseli'),
          ),
          ListTile(
            leading:
                Icon(FeatherIcons.github, color: theme.colorScheme.secondary),
            // title: const Text('https://github.com/yalda-student/student_note'),
            title: TextButton(
                onPressed: () => _launchURL(),
                child:
                    const Text('Github', style: TextStyle(color: Colors.black))),
          ),
          ListTile(
            leading:
                Icon(FeatherIcons.linkedin, color: theme.colorScheme.secondary),
            title: const Text(
                'https://www.linkedin.com/in/yalda-mohasseli-270049178/'),
          ),
        ],
      ),
    );
  }

  void _launchURL() async {

    if (await canLaunch(AppConstants.githubUrl)) {
      await launch(AppConstants.githubUrl);
    } else {
      throw "Could not launch ${AppConstants.githubUrl}";
    }
  }
}
