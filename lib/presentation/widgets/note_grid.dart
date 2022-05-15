import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/widgets/note_grid_item.dart';
import 'package:yalda_students_notes/presentation/widgets/note_item.dart';

class NoteGrid extends StatelessWidget {
  final List<NoteModel> data;

  const NoteGrid({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ResponsiveGridView.builder(
      itemCount: data.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      gridDelegate:  const ResponsiveGridDelegate(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: ValueManager.gridSpacing,
          mainAxisSpacing: ValueManager.gridSpacing),
      itemBuilder: (context, index) => NoteItem(
        noteItem: NoteGridItem(data: data[index]),
        data: data[index],
      ),
    ));
  }
}
