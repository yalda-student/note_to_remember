import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
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
              title: const Text(
                'Edit Note',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    closePage();
                  },
                  icon: const Icon(Iconsax.close_circle, color: Colors.black)),
              actions: [
                IconButton(
                  onPressed: () {
                    updateNote(context);
                  },
                  //save icon
                  icon: const Icon(Iconsax.note_add,
                      color: Colors.black),
                ),
                IconButton(
                    onPressed: () {
                      deleteNote(context);
                    },
                    icon: const Icon(Iconsax.note_remove, color: Colors.black))
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
            _TitleTextField(titleController: _titleController, theme: theme),
            const SizedBox(height: 4),
            Expanded(
              child: _ContentTextField(contentController: _contentController),
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
      closePage();
    }
  }

  void deleteNote(BuildContext context) {
    var appDb = Provider.of<AppDatabase>(context, listen: false);
    appDb.deleteNote(widget.data.id);
    closePage();
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

class _TitleTextField extends StatelessWidget {
  const _TitleTextField({
    Key? key,
    required TextEditingController titleController,
    required this.theme,
  })  : _titleController = titleController,
        super(key: key);

  final TextEditingController _titleController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _titleController,
      maxLength: 255,
      decoration: InputDecoration(
        hintText: 'Title',
        counterStyle: const TextStyle(color: Colors.black),
        hintStyle: theme.textTheme.headline5!
            .copyWith(color: Colors.black54, fontWeight: FontWeight.w600),
      ),
      cursorColor: theme.colorScheme.secondary,
      textInputAction: TextInputAction.next,
      style: theme.textTheme.headline5!.copyWith(
          color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
    );
  }
}

class _ContentTextField extends StatelessWidget {
  const _ContentTextField({
    Key? key,
    required TextEditingController contentController,
  })  : _contentController = contentController,
        super(key: key);

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _contentController,
      decoration: const InputDecoration(hintText: 'Start typing'),
      style: const TextStyle(color: Colors.black),
      maxLines: 100,
      keyboardType: TextInputType.multiline,
      cursorColor: Colors.black,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Content cannot be empty.';
        }
        return null;
      },
    );
  }
}
