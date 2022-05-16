import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/datasource/shared_pref.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/category_notes/bloc/category_notes_bloc.dart';
import 'package:yalda_students_notes/presentation/widgets/empty_state.dart';
import 'package:yalda_students_notes/presentation/widgets/invalid_state.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';
import 'package:yalda_students_notes/presentation/widgets/note_category_item.dart';

class CategoryNotesScreen extends StatelessWidget {
  CategoryModel category;

  CategoryNotesScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String title = '';

    return Scaffold(body: Consumer<AppDatabase>(
      builder: (context, value, child) {
        context.read<CategoryNotesBloc>().add(CategoryNoteStart(category.id));

        return Column(
          children: [
            BlocBuilder<CategoryNotesBloc, CategoryNotesState>(
              buildWhen: (previous, current) {
                if (current is CategoryNotesName) {
                  title = current.title;
                  category = CategoryModel(
                      id: category.id, title: title, color: category.color);
                }
                return current is CategoryNotesName;
              },
              builder: (context, state) {
                state is CategoryNotesName ? title = state.title : '';
                return AppBar(
                  title: Text(state is CategoryNotesName ? state.title : title,
                      style: TextStyle(color: theme.colorScheme.secondary)),
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                        EasyLocalization.of(context)!.currentLocale ==
                                const Locale('en', 'US')
                            ? Iconsax.arrow_circle_left
                            : Iconsax.arrow_circle_right,
                        color: theme.colorScheme.secondary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  actions: [
                    //None category cannot rename
                    if (category.id != 1) ...[
                      IconButton(
                          onPressed: () => _showDialog(context, theme),
                          icon: Icon(Iconsax.edit_2,
                              color: theme.colorScheme.secondary))
                    ]
                  ],
                );
              },
            ),
            const Divider(),
            BlocBuilder<CategoryNotesBloc, CategoryNotesState>(
              buildWhen: (previous, current) => current is! CategoryNotesName,
              builder: (context, state) {
                return _handleStates(state);
              },
            )
          ],
        );
      },
    ));
  }

  Future<void> _showDialog(BuildContext context, ThemeData theme) async {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.onPrimary.withOpacity(0.5), width: 2.0),
      borderRadius: BorderRadius.circular(12.0),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Rename category'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s20))),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  maxLength: 255,
                  initialValue: category.title,
                  decoration: InputDecoration(
                      hintText: 'Category',
                      filled: true,
                      fillColor: theme.colorScheme.surface.withOpacity(0.5),
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      contentPadding: const EdgeInsets.all(AppPadding.p10)),
                  onChanged: (value) {
                    context
                        .read<CategoryNotesBloc>()
                        .add(CategoryNoteTextFieldChange(value));
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: theme.colorScheme.secondary.withOpacity(0.7)),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Rename',
                style: TextStyle(color: theme.colorScheme.secondary)),
            onPressed: () {
              context.read<CategoryNotesBloc>().add(CategoryNoteRename());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _handleStates(CategoryNotesState state) {
    if (state is CategoryNotesLoading || state is CategoryNotesInitial) {
      return const LoadingState();
    } else if (state is CategoryNotesEmptyState) {
      return const EmptyState();
    } else if (state is CategoryNotesSuccess) {
      return ResponsiveVisibility(
        child: _NoteList(data: state.data),
        replacement: _NoteGrid(data: state.data),
        hiddenWhen: const [Condition.largerThan(name: MOBILE)],
      );
    } else {
      debugPrint(state.toString());
      return const InvalidState();
    }
  }
}

class _NoteList extends StatelessWidget {
  final List<NoteModel> data;

  const _NoteList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint('_NoteList');
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.fromLTRB(
                  AppSize.s8, AppSize.s16, AppSize.s8, AppSize.s0),
              child: NoteCategoryItem(note: data[index]));
        },
      ),
    );
  }
}

class _NoteGrid extends StatelessWidget {
  final List<NoteModel> data;

  const _NoteGrid({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: SharedPref.getLanguage().isLanguageRtl()
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p12),
        physics: const BouncingScrollPhysics(),
        child: Wrap(
          alignment: WrapAlignment.end,
          runSpacing: ValueManager.gridSpacing,
          spacing: ValueManager.gridSpacing,
          children: List.generate(data.length, (index) {
            return NoteCategoryItem(note: data[index]);
          }),
        ),
      ),
    );
  }
}
