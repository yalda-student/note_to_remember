import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/data/source/database.dart';

class SmallNoteItem extends StatefulWidget {
  const SmallNoteItem({Key? key, required this.data}) : super(key: key);

  final NoteData data;

  @override
  State<SmallNoteItem> createState() => _SmallNoteItemState();
}

class _SmallNoteItemState extends State<SmallNoteItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => openEditPage(),
      onDoubleTap: () => starNote(),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
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
              Container(
                margin: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: theme.colorScheme.secondary),
                    ),
                    widget.data.isFavorite
                        ? const Icon(Iconsax.star1,
                            color: Colors.amber, size: 20)
                        : const SizedBox()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'School cat.',
                    style: TextStyle(
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
      ),
    );
  }

  void starNote() {
    var db = context.read<AppDatabase>();
    db.updateNote(NoteData(
        id: widget.data.id,
        title: widget.data.title,
        content: widget.data.content,
        createdAt: widget.data.createdAt,
        color: widget.data.color,
        isFavorite: !widget.data.isFavorite));
    setState(() {});
  }

  void openEditPage() {
    Navigator.of(context).pushNamed(
      AppConstants.editNoteRoute,
      arguments: widget.data,
    );
  }
}
