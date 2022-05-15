import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';

class NoteListItem extends StatefulWidget {
  const NoteListItem({Key? key, required this.data}) : super(key: key);

  final NoteModel data;

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: isMobile(context) ? MediaQuery.of(context).size.width : 50,
      margin: const EdgeInsets.fromLTRB(2, 12, 2, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(widget.data.color).withOpacity(0.85),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 0.3),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(widget.data.color),
                Color(widget.data.color).withOpacity(0.55),
              ])),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
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
                      maxLines: 1, style: FontManager.noteTitleTextStyle()),
                ),
                if (widget.data.isFavorite)
                  const Icon(Iconsax.heart5, color: Colors.red, size: 20)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data.category,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(widget.data.createdAt),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
