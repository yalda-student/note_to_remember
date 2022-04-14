import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/screen/edit_note/bloc/editnote_bloc.dart';
import 'package:yalda_students_notes/screen/edit_note/edit_note_screen.dart';
import 'package:yalda_students_notes/screen/note/bloc/notelist_bloc.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({Key? key, required this.data}) : super(key: key);

  final NoteModel data;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
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
                    Expanded(
                      child: Text(
                        widget.data.title ?? '',
                        maxLines: 1,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: theme.colorScheme.secondary),
                      ),
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
      ),
    );
  }

  void starNote() {
    final note = widget.data;
    context.read<NoteListBloc>().add(
          NoteListStar(
            NoteData(
                id: note.id,
                title: note.title,
                content: note.content,
                createdAt: note.createdAt,
                color: note.color,
                isFavorite: !note.isFavorite,
                categoryId: note.categoryId),
          ),
        );
  }

  void openEditPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BlocProvider<EditNoteBloc>(
          create: (context) =>
              EditNoteBloc(context.read<AppDatabase>(), widget.data),
          child: const EditNoteScreen(),
        ),
      ),
    );
  }
}
