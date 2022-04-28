
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/data/model/note_model.dart';
import 'package:yalda_students_notes/ui/widgets/note_item.dart';

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
            data: data[index],
          );
        },
      ),
    );
  }
}
