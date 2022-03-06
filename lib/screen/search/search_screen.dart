import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/widgets/empty_state.dart';
import 'package:yalda_students_notes/widgets/note_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final db = Provider.of<AppDatabase>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search',
                icon: Icon(
                  Iconsax.search_normal,
                  color: theme.colorScheme.secondary,
                ),
              ),
              textInputAction: TextInputAction.search,
              onChanged: (term) {
                setState(() {});
              },
            ),
          ),
          const Divider(),
          StreamBuilder<List<NoteData>>(
              stream: db.getAllNotes(keyword: _controller.text),
              builder: (context, snapshotdata) {
                if (snapshotdata.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshotdata.data!.isEmpty || _controller.text.isEmpty) {
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
      )),
    );
  }
}
