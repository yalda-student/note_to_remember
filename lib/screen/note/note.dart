import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/gen/assets.gen.dart';
import 'package:yalda_students_notes/widgets/note_item.dart';

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
                builder: (coontext, snapshotdata) {
                  if (snapshotdata.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshotdata.data!.isEmpty) {
                    return Expanded(
                      child: Column(
                        children: const [
                          SizedBox(height: 100),
                          _EmptyState(),
                        ],
                      ),
                    );
                  }
                  return _NoteList(
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
              Navigator.pushNamed(context, AppConstants.addNoteRoute);
            },
            child: Icon(Iconsax.add, color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.image.error404.image(width: 180),
        const Text(
          "You don't have any note.",
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
        )
      ],
    );
  }
}

class _NoteList extends StatelessWidget {
  final List<NoteData> data;
  const _NoteList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return SmallNoteItem(
            data: data[index],
          );
        },
      ),
    );
  }
}
