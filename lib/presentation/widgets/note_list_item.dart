import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/style_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';

class NoteListItem extends StatefulWidget {
  const NoteListItem({Key? key, required this.data}) : super(key: key);

  final NoteModel data;

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 100,
      margin: const EdgeInsets.fromLTRB(2, 12, 2, 0),
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: Color(widget.data.color).withOpacity(0.3),
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
                  child: Text(widget.data.title,
                      maxLines: 1,
                      style: StyleManager.noteTitleTextStyle(theme)),
                ),
                if (widget.data.isFavorite)
                  Icon(Iconsax.heart5, color: theme.errorColor, size: 20)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data.category,
                  style:  TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: theme.colorScheme.onSurface),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.data.createdAt),
                  textAlign: TextAlign.start,
                  style:  TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
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
