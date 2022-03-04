import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/widgets/color_picker.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteData data;
  const EditNoteScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  int colorIndex = 0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    initialFileds();

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: colors[colorIndex],
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppBar(
              backgroundColor: colors[colorIndex],
              title: Text(
                'Edit Note',
                style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    closePage();
                  },
                  icon: Icon(Iconsax.close_circle,
                      color: theme.colorScheme.secondary)),
              actions: [
                IconButton(
                    onPressed: () {
                      updateNote(context);
                    },
                    icon: Icon(Icons.check_circle_outline_rounded,
                        color: theme.colorScheme.secondary))
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            ColorPicker(
                selectedIndex: colorIndex,
                onTap: (index) {
                  colorIndex = index;
                  setState(() {});
                }),
            const SizedBox(height: 8),
            TextFormField(
              controller: _titleController,
              maxLength: 255,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: theme.textTheme.headline5!.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.w600),
              ),
              cursorColor: theme.colorScheme.secondary,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 4),
            Expanded(
              child: TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Start typing',
                ),
                maxLines: 12,
                cursorColor: theme.colorScheme.secondary,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Content cannot be empty.';
                  }
                  return null;
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  void updateNote(BuildContext context) {
    var validate = _formKey.currentState!.validate();

    if (validate) {
      var appDb = Provider.of<AppDatabase>(context, listen: false);
      appDb.updateNote(NoteData(
        id: widget.data.id,
        title: _titleController.text,
        content: _contentController.text,
        color: colors[colorIndex].value,
        createdAt: DateTime.now(),
        isFavorite: widget.data.isFavorite,
      ));
      Navigator.pop(context);
    }
  }

  void closePage() {
    Navigator.pop(context);
  }

  void initialFileds() {
    final note = widget.data;
    _titleController.text = note.title!;
    _contentController.text = note.content;
    colorIndex = colors.indexOf(Color(note.color));
  }
}
