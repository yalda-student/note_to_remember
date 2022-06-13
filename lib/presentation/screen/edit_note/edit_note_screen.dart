import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/app/app.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/repository/category_repository_impl.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/edit_note/bloc/editnote_bloc.dart';
import 'package:yalda_students_notes/presentation/util/theme_util.dart';
import 'package:yalda_students_notes/presentation/widgets/bottom_sheet.dart';
import 'package:yalda_students_notes/presentation/widgets/color_picker.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';
import 'package:yalda_students_notes/presentation/widgets/pop_menu_item.dart';

int colorIndex = 0;
bool? _isDark;
final _formKey = GlobalKey<FormState>();

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late Color backGroundColor;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    _initialFields();
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

    _isDark = Provider.of<ThemeNotifier>(context, listen: false).isDark();
    setBackgroundColor();

    return BlocBuilder<EditNoteBloc, EditNoteState>(
      builder: (ctx, state) {
        return Scaffold(
          backgroundColor: backGroundColor,
          body: SafeArea(
              child: state is EditNoteInitial
                  ? Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const _AppBar(),
                          const Divider(),
                          const SizedBox(height: 8),
                          ColorPicker(
                              selectedIndex: colorIndex,
                              onTap: (index) {
                                colorIndex = index;
                                setBackgroundColor();
                                context
                                    .read<EditNoteBloc>()
                                    .add(EditNoteColorChange(colorIndex));
                              }),
                          const SizedBox(height: 8),
                          _TitleTextField(
                              titleController: _titleController, theme: theme),
                          const SizedBox(height: 4),
                          Expanded(
                            child: _ContentTextField(
                                contentController: _contentController),
                          )
                        ],
                      ),
                    )
                  : const LoadingState()),
        );
      },
    );
  }

  void setBackgroundColor() {
    final color = ColorManager.noteColors[colorIndex];
    backGroundColor = _isDark! ? color.darkColor : color.lightColor;
  }

  void _initialFields() {
    final note = context.read<EditNoteBloc>().state.noteData;
    _titleController.text = note.title;
    _contentController.text = note.content;
    colorIndex = note.colorIndex;
  }
}

class _AppBar extends StatelessWidget with ExtractCategoryData {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<EditNoteBloc, EditNoteState>(
      buildWhen: (previous, current) => current is EditNoteInitial,
      builder: (context, state) {
        final color = ColorManager.noteColors[colorIndex];
        Color backGroundColor = _isDark! ? color.darkColor : color.lightColor;

        return state is EditNoteInitial
            ? AppBar(
                backgroundColor: backGroundColor,
                title: Text(
                  LocaleKeys.editNote.tr(),
                  style: theme.appBarTheme.titleTextStyle!
                      .copyWith(fontSize: FontSize.onBoardBody(context)),
                ),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () => _closePage(context),
                    icon: Icon(Iconsax.close_circle,
                        color: ColorManager.getNoteEditorTextColor(theme))),
                actions: [
                  ResponsiveVisibility(
                    hiddenWhen: const [Condition.largerThan(name: MOBILE)],
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext ctx) => popupMenuItems,
                      onSelected: (value) =>
                          _handleMenuItemSelect(context, value),
                    ),
                  ),
                  ResponsiveVisibility(
                    visible: false,
                    visibleWhen: const [Condition.largerThan(name: MOBILE)],
                    child: IconButton(
                      tooltip: LocaleKeys.delete.tr(),
                      onPressed: () => _deleteNote(context),
                      icon: Icon(Iconsax.note_remove,
                          color: ColorManager.getNoteEditorTextColor(theme),
                          size: AppSize.iconSize(context)),
                    ),
                  ),
                  ResponsiveVisibility(
                    visible: false,
                    visibleWhen: const [Condition.largerThan(name: MOBILE)],
                    child: IconButton(
                      tooltip: LocaleKeys.move.tr(),
                      onPressed: () => _openCategoryList(context),
                      icon: Icon(Iconsax.category_2,
                          color: ColorManager.getNoteEditorTextColor(theme),
                          size: AppSize.iconSize(context)),
                    ),
                  ),
                  ResponsiveVisibility(
                    visible: false,
                    visibleWhen: const [Condition.largerThan(name: MOBILE)],
                    child: IconButton(
                        tooltip: LocaleKeys.update.tr(),
                        onPressed: () => _updateNote(context),
                        icon: Icon(Iconsax.note_add,
                            color: ColorManager.getNoteEditorTextColor(theme),
                            size: AppSize.iconSize(context))),
                  ),
                ],
              )
            : const LoadingState();
      },
    );
  }

  void _handleMenuItemSelect(BuildContext context, value) {
    switch (value) {
      case 0:
        _updateNote(context);
        break;
      case 1:
        _openCategoryList(context);
        break;
      case 2:
        _deleteNote(context);
        break;
      default:
    }
  }

  void _updateNote(BuildContext context) {
    var validate = _formKey.currentState!.validate();

    if (validate) {
      context.read<EditNoteBloc>().add(EditNoteUpdate());
      _closePage(context);
    }
  }

  void _deleteNote(BuildContext context) {
    context.read<EditNoteBloc>().add(EditNoteDelete());
    _closePage(context);
  }

  void _closePage(BuildContext context) => Navigator.of(context).pop();

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

    context.read<EditNoteBloc>().add(EditNoteCategoryChange(categoryModel));
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
        // counterStyle: StyleManager.counterTextStyle(theme),
        hintStyle: theme.textTheme.headline5!
            .copyWith(color: Colors.black54, fontWeight: FontWeight.w600),
      ),
      onChanged: (value) {
        context.read<EditNoteBloc>().add(EditNoteTitleChange(value));
      },
      cursorColor: theme.colorScheme.secondary,
      textInputAction: TextInputAction.next,
      style: theme.textTheme.headline5!.copyWith(
          color: ColorManager.getNoteEditorTextColor(theme).withOpacity(0.8),
          fontWeight: FontWeight.w600),
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
      decoration: InputDecoration(hintText: LocaleKeys.startTyping.tr()),
      style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75)),
      maxLines: 100,
      keyboardType: TextInputType.multiline,
      cursorColor: Colors.black,
      validator: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.content_Cannot_Be_Empty;
        }
        return null;
      },
      onChanged: (value) {
        context.read<EditNoteBloc>().add(EditNoteContentChange(value));
      },
    );
  }
}

final popupMenuItems = <PopupMenuEntry>[
  PopupMenuItem(
      value: 0,
      child: AppPopupMenuItem(
          title: LocaleKeys.update.tr(), icon: Iconsax.note_add)),
  PopupMenuItem(
      value: 1,
      child: AppPopupMenuItem(
          title: LocaleKeys.move.tr(), icon: Iconsax.category_2)),
  PopupMenuItem(
      value: 2,
      child: AppPopupMenuItem(
          title: LocaleKeys.delete.tr(), icon: Iconsax.note_remove)),
];
