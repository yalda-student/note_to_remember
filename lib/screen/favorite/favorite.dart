import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/widgets/empty_state.dart';
import 'package:yalda_students_notes/widgets/note_list.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        ListTile(
          title: const Text(
            'Starred Notes',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          leading: Icon(
            Iconsax.note_favorite,
            color: theme.colorScheme.secondary,
          ),
        ),
        StreamBuilder<List<NoteData>>(
            stream: db.getStarNotes(),
            builder: (coontext, snapshotdata) {
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
    );
  }
}
