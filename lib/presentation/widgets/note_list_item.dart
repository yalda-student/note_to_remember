import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/app/functions.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/style_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/util/color_util.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({Key? key, required this.data}) : super(key: key);

  final NoteModel data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String date;
    if (EasyLocalization.of(context)!.currentLocale !=
        const Locale('en', 'US')) {
      date = convertToJalaliDate(data.createdAt);
    } else {
      date = DateFormat('dd/MM/yyyy').format(data.createdAt);
    }

    return Container(
      height: 100,
      margin: const EdgeInsets.fromLTRB(2, 12, 2, 0),
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: getNoteColor(context, data.colorIndex),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(data.title,
                      maxLines: 1,
                      style: StyleManager.noteTitleTextStyle(theme)),
                ),
                if (data.isFavorite)
                  Icon(Iconsax.heart5,
                      color: theme.errorColor, size: AppSize.s20)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.category,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: FontSize.s13,
                      color: theme.colorScheme.onSurface),
                ),
                Text(
                  date,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: FontSize.s13,
                      color: theme.colorScheme.onSurface),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
