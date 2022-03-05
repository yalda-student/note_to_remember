import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/screen/add_note/add_note_screen.dart';
import 'package:yalda_students_notes/widgets/empty_state.dart';
import 'package:yalda_students_notes/widgets/note_list.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final db = Provider.of<AppDatabase>(context);
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'List Notes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Icon(Iconsax.sort)
              ],
            ),
            StreamBuilder<List<NoteData>>(
                stream: db.getAllNotes(),
                builder: (context, snapshotdata) {
                  if (snapshotdata.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshotdata.data!.isEmpty) {
                    return Expanded(
                      child: Column(
                        children: const [
                          SizedBox(height: 100),
                          EmptyState(),
                        ],
                      ),
                    );
                  }
                  return NoteList(
                    data: snapshotdata.data!,
                  );
                })
          ],
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddNoteScreen(),
                  ));
            },
            child: Icon(Iconsax.add, color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
