import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/common/util/color_util.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';

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

    // debugPrint(note.toString());
    return Container(
      width: 170,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
          color: noteColor, borderRadius: BorderRadius.circular(15)),
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
        expanded: Text(
          note.content,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: FontSize.s16,
              color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}
