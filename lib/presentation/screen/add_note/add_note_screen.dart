import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yalda_students_notes/common/color.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/repository/category_repository.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/screen/add_note/bloc/addnote_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/home/home_screen.dart';
import 'package:yalda_students_notes/presentation/widgets/bottom_sheet.dart';
import 'package:yalda_students_notes/presentation/widgets/color_picker.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen>
    with ExtractCategoryData {
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
                    LocaleKeys.add_note,
                    style: TextStyle(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold),
                  ).tr(),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () {
                        closePage();
                      },
                      icon: Icon(Iconsax.close_circle,
                          color: theme.colorScheme.secondary)),
                  actions: [
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () => saveNote(context),
                            icon: const Icon(Iconsax.note_add,
                                color: Colors.black),
                            label: Text(
                              LocaleKeys.save.tr(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () => _openCategoryList(context),
                            icon: const Icon(Iconsax.category_2,
                                color: Colors.black),
                            label: Text(
                              LocaleKeys.move.tr(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
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
      closePage();
    }
  }

  void closePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void _openCategoryList(BuildContext context) async {
    final result = await showCupertinoModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      bounce: true,
      topRadius: const Radius.circular(15),
      duration: const Duration(milliseconds: 750),
      builder: (context) => BlocProvider(
        create: (context) => CategoryBloc(
            CategoryRepository(context.read<AppDatabase>()),
            CategoryModel(title: '', color: generateColor())),
        child: const CategoryBottomSheet(),
      ),
    );

    var categoryModel = extractCategoryData(result);

    context.read<AddNoteBloc>().add(AddNoteCategoryChange(categoryModel));
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
        hintText: LocaleKeys.title.tr(),
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
        decoration: InputDecoration(
          hintText: LocaleKeys.startTyping.tr(),
        ),
        maxLines: 12,
        cursorColor: theme.colorScheme.secondary,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.content_Cannot_Be_Empty.tr();
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
