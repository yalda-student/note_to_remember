import 'package:flutter/material.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';
import 'package:yalda_students_notes/presentation/widgets/note_item.dart';
import 'package:yalda_students_notes/presentation/widgets/note_list_item.dart';

class NoteList extends StatelessWidget {
  final List<NoteModel> data;
  const NoteList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return NoteItem(
            noteItem: NoteListItem(data: data[index]),
            data: data[index],
          );
        },
      ),
    );
  }
}
