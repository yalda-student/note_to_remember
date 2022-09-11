import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/util/color_util.dart';
import 'package:yalda_students_notes/presentation/widgets/top_snackbar/custom_snack_bar.dart';
import 'package:yalda_students_notes/presentation/widgets/top_snackbar/top_snack_bar.dart';

class NoteCategoryItem extends StatelessWidget {
  final NoteModel note;

  const NoteCategoryItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final noteColor = getNoteColor(context, note.colorIndex);

    return Container(
      width: 170,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
          color: noteColor, borderRadius: BorderRadius.circular(AppSize.s15)),
      child: ExpandablePanel(
        theme: ExpandableThemeData(iconColor: theme.colorScheme.onSurface),
        header: Text(
          note.title,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w800,
              fontSize: FontSize.s19,
              color: theme.colorScheme.onSurface),
        ),
        collapsed: Text(
          note.content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: FontSize.s15,
              color: theme.colorScheme.onSurface),
        ),
        expanded: DetectableText(
          text: note.content,
          softWrap: true,
          detectionRegExp: detectionRegExp(atSign: false, hashtag: false)!,
          basicStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: FontSize.s16,
              color: theme.colorScheme.onSurface),
          onTap: (text) async {
            await Clipboard.setData(ClipboardData(text: text));
            showTopSnackBar(
                context, CustomSnackBar.info(message: LocaleKeys.copy.tr()));
          },
          detectedStyle: const TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w500,
              fontSize: FontSize.s16,
              color: ColorManager.radioButtonColor),
        ),
      ),
    );
  }
}
