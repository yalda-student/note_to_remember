import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/data/datasource/shared_pref.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/style_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';

class NoteGridItem extends StatelessWidget {
  final NoteModel data;

  const NoteGridItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: Color(data.color).withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Align(
        alignment: SharedPref.getLanguage().isLanguageRtl()
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
                    child: Icon(
                      Iconsax.heart5,
                      color: theme.errorColor,
                      size: AppSize.s16,
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
