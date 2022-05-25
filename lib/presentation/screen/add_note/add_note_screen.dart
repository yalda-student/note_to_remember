import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/category_repository.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/screen/add_note/bloc/addnote_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/home/home_screen.dart';
import 'package:yalda_students_notes/presentation/widgets/bottom_sheet.dart';
import 'package:yalda_students_notes/presentation/widgets/color_picker.dart';
import 'package:yalda_students_notes/presentation/widgets/pop_menu_item.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen>
    with ExtractCategoryData {
  int colorIndex = 0;
  late bool? isMobile;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    isMobile = ResponsiveValue<bool>(context,
            defaultValue: true,
            valueWhen: [const Condition.largerThan(name: MOBILE, value: false)])
        .value;

    return BlocProvider<AddNoteBloc>(
      create: (context) {
        final _note = NoteModel(
          title: '',
          content: '',
          isFavorite: false,
          color: Colors.white.value,
          createdAt: DateTime.now(),
        );
        return AddNoteBloc(NoteRepository(context.read<AppDatabase>()), _note);
      },
      child: BlocBuilder<AddNoteBloc, AddNoteState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorManager.colors[colorIndex],
            body: SafeArea(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: ColorManager.colors[colorIndex],
                    title: Text(
                      LocaleKeys.add_note.tr(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    leading: isMobile!
                        ? IconButton(
                            onPressed: () => closePage(),
                            icon: const Icon(Iconsax.close_circle,
                                color: Colors.black))
                        : const SizedBox(),
                    actions: [
                      ResponsiveVisibility(
                        hiddenWhen: const [Condition.largerThan(name: MOBILE)],
                        child: PopupMenuButton(
                          itemBuilder: (BuildContext context1) =>
                              popupMenuItems,
                          onSelected: (value) =>
                              _handleMenuItemSelect(context, value),
                        ),
                      ),
                      ResponsiveVisibility(
                        visible: false,
                        visibleWhen: const [Condition.largerThan(name: MOBILE)],
                        child: TextButton(
                          onPressed: () => _openCategoryList(context),
                          child: Text(LocaleKeys.move.tr(),
                              style: const TextStyle(color: Colors.black)),
                        ),
                      ),
                      ResponsiveVisibility(
                        visible: false,
                        visibleWhen: const [Condition.largerThan(name: MOBILE)],
                        child: TextButton(
                          onPressed: () => _saveNote(context),
                          child: Text(LocaleKeys.save.tr(),
                              style: const TextStyle(color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  ColorPicker(
                      selectedIndex: colorIndex,
                      onTap: (index) {
                        colorIndex = index;
                        context.read<AddNoteBloc>().add(
                            AddNoteColorChange(ColorManager.colors[index]));
                      }),
                  const SizedBox(height: 8),
                  _TitleTextField(
                      titleController: _titleController, theme: theme),
                  const SizedBox(height: 4),
                  _ContentTextField(
                      contentController: _contentController, theme: theme)
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  void _handleMenuItemSelect(BuildContext context, value) {
    switch (value) {
      case 0:
        _saveNote(context);
        break;
      case 1:
        _openCategoryList(context);
        break;
      default:
    }
  }

  void _saveNote(BuildContext context) {
    final validate = _formKey.currentState!.validate();

    if (validate) {
      context.read<AddNoteBloc>().add(AddNoteSave());
      closePage();
    }
  }

  void closePage() {
    if (isMobile!) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
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
      style: theme.textTheme.headline5!.copyWith(
          color: theme.colorScheme.onPrimary, fontWeight: FontWeight.w600),
      onChanged: (value) {
        context.read<AddNoteBloc>().add(AddNoteTitleChange(value));
      },
    );
  }
}

class _ContentTextField extends StatelessWidget {
  const _ContentTextField({
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
          hintStyle: theme.textTheme.headline5!
              .copyWith(color: Colors.black54, fontWeight: FontWeight.w600),
        ),
        maxLines: 100,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
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

final popupMenuItems = <PopupMenuEntry>[
  PopupMenuItem(
      value: 0,
      child: AppPopupMenuItem(
          title: LocaleKeys.save.tr(), icon: Iconsax.note_add)),
  PopupMenuItem(
      value: 1,
      child: AppPopupMenuItem(
          title: LocaleKeys.move.tr(), icon: Iconsax.category_2)),
];
