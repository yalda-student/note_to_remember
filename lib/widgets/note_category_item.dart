import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/source/database.dart';

class NoteCategoryItem extends StatefulWidget {
  final NoteData note;

  const NoteCategoryItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<NoteCategoryItem> createState() => _NoteCategoryItemState();
}

class _NoteCategoryItemState extends State<NoteCategoryItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      decoration: BoxDecoration(
        color: Color(widget.note.color).withOpacity(0.85),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 0.3),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(widget.note.color),
            Color(widget.note.color).withOpacity(0.55),
          ],
        ),
      ),
      child: ExpandablePanel(
        header: Text(
          widget.note.title ?? '',
          style: TextStyle(
          overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w800,
              fontSize: 19,
              color: theme.colorScheme.secondary),
        ),
        collapsed: Text(
          widget.note.content,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: theme.colorScheme.secondary),
        ),
        expanded: Text(
          widget.note.content,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
              color: theme.colorScheme.secondary),
        ),
      ),
    );
  }
}