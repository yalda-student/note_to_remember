import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/app/app_prefs.dart';
import 'package:yalda_students_notes/app/di.dart';
import 'package:yalda_students_notes/app/extensions.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/style_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/util/color_util.dart';

class NoteGridItem extends StatelessWidget {
  final NoteModel data;

  const NoteGridItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appPref = instance<AppPreferences>();

    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: getNoteColor(context, data.colorIndex),
        borderRadius: BorderRadius.circular(15),
      ),
      child: FutureBuilder<String>(
          future: appPref.getLanguage(),
          initialData: const Locale('en', 'US').languageCode,
          builder: (context, snapshot) {
            return Align(
              alignment: snapshot.data!.isLanguageRtl()
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(data.title,
                      style: StyleManager.noteTitleTextStyle(theme),
                      textAlign: TextAlign.start),
                  const SizedBox(height: AppSize.s12),
                  Expanded(
                    child: Text(
                      data.content,
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.start,
                      style: StyleManager.noteContentTextStyle(theme),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data.category,
                          style: StyleManager.noteCategoryTextStyle(theme)),
                      if (data.isFavorite)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Iconsax.heart5,
                              color: theme.errorColor, size: AppSize.s16),
                        )
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
