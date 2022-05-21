import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/common/lang.dart';

enum Language { english, persian }

class LanguageRadioButton extends StatefulWidget {
  const LanguageRadioButton({Key? key}) : super(key: key);

  @override
  _LanguageRadioButtonState createState() => _LanguageRadioButtonState();
}

class _LanguageRadioButtonState extends State<LanguageRadioButton>
    with AppLanguage {
  @override
  Widget build(BuildContext context) {
    final appLanguage =
        EasyLocalization.of(context)!.currentLocale == const Locale('en', 'US')
            ? Language.english
            : Language.persian;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(languagesList[0]),
            leading: Radio(
              value: Language.english,
              groupValue: appLanguage,
              onChanged: (Language? value) =>
                  onLanguageChange(context, const Locale('en', 'US')),
            ),
          ),
          ListTile(
            title: Text(languagesList[1]),
            leading: Radio(
              value: Language.persian,
              groupValue: appLanguage,
              onChanged: (Language? value) =>
                  onLanguageChange(context, const Locale('fa', 'IR')),
            ),
          ),
        ],
      ),
    );
  }
}
