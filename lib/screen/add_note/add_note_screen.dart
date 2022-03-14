import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/screen/add_note/bloc/addnote_bloc.dart';
import 'package:yalda_students_notes/widgets/color_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int colorIndex = 0;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
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
    return BlocBuilder<AddNoteBloc, AddNoteState>(
      builder: (context, state) {
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
                    'Add Note',
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
                          saveNote(context);
                        },
                        icon: Icon(Iconsax.note_add,
                            color: theme.colorScheme.secondary))
                  ],
                ),
                const Divider(),
                const SizedBox(height: 8),
                ColorPicker(
                    selectedIndex: colorIndex,
                    onTap: (index) {
                      colorIndex = index;
                      context
                          .read<AddNoteBloc>()
                          .add(AddNoteColorChange(colors[index]));
                    }),
                const SizedBox(height: 8),
                _TitleTextField(
                    titleController: _titleController, theme: theme),
                const SizedBox(height: 4),
                _ContextTextField(
                    contentController: _contentController, theme: theme)
              ],
            ),
          )),
        );
      },
    );
  }

  void saveNote(BuildContext context) {
    var validate = _formKey.currentState!.validate();

    if (validate) {
      context.read<AddNoteBloc>().add(AddNoteSave());
      Navigator.of(context).pop();
    }
  }

  void closePage() {
    Navigator.pop(context);
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
        hintStyle: theme.textTheme.headline5!
            .copyWith(color: Colors.black54, fontWeight: FontWeight.w600),
      ),
      cursorColor: theme.colorScheme.secondary,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        context.read<AddNoteBloc>().add(AddNoteTitleChange(value));
      },
    );
  }
}

class _ContextTextField extends StatelessWidget {
  const _ContextTextField({
    Key? key,
    required TextEditingController contentController,
    required this.theme,
  })  : _contentController = contentController,
        super(key: key);

  final TextEditingController _contentController;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
        onChanged: (value) {
          context.read<AddNoteBloc>().add(AddNoteContentChange(value));
        },
      ),
    );
  }
}
