import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/gen/assets.gen.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
           const SizedBox(height: 100),
          Assets.image.error404.image(width: 180, color: Theme.of(context).colorScheme.secondary),
           Text(
            LocaleKeys.any_note.tr(),
            style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
          )
        ],
      ),
    );
  }
}
