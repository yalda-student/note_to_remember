import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/datasource/shared_pref.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/add_note/add_note_screen.dart';
import 'package:yalda_students_notes/presentation/screen/note/bloc/notelist_bloc.dart';
import 'package:yalda_students_notes/presentation/widgets/empty_state.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';
import 'package:yalda_students_notes/presentation/widgets/note_grid.dart';
import 'package:yalda_students_notes/presentation/widgets/note_list.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p12),
      child: Stack(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(LocaleKeys.notesList.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: FontSize.s17)),
                leading:
                    Icon(Iconsax.note_21, color: theme.colorScheme.onSurface),
              ),
              Consumer<AppDatabase>(
                builder: (context, value, child) {
                  context.read<NoteListBloc>().add(NoteListStart());
                  return BlocBuilder<NoteListBloc, NoteListState>(
                    builder: (context, state) {
                      return _handleStates(state);
                    },
                  );
                },
              )
            ],
          ),
          Align(
            alignment: SharedPref.getLanguage().isLanguageRtl()
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: ResponsiveVisibility(
              hiddenWhen: const [Condition.largerThan(name: MOBILE)],
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p6),
                child: FloatingActionButton(
                  backgroundColor: theme.colorScheme.onSurface,
                  onPressed: () => _openAddNotePage(context),
                  child: Icon(Iconsax.add, color: theme.colorScheme.primary),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _handleStates(NoteListState state) {
    if (state is NoteListSuccess) {
      return ResponsiveVisibility(
        hiddenWhen: const [Condition.largerThan(name: MOBILE)],
        child: NoteList(data: state.noteList),
        replacement: NoteGrid(data: state.noteList),
      );
    } else if (state is NoteListEmpty) {
      return const EmptyState();
    } else if (state is NoteListLoading || state is NoteListInitial) {
      return const LoadingState();
    } else if (state is NoteListError) {
      return Center(child: Text(state.errorMessage));
    } else {
      throw Exception('Invalid State');
    }
  }

  void _openAddNotePage(BuildContext context) {
    NoteModel(
      title: '',
      content: '',
      isFavorite: false,
      colorIndex: Colors.white.value,
      createdAt: DateTime.now(),
    );
    Navigator.of(context).push(_getAnimatedRoute());
  }

  PageRouteBuilder<dynamic> _getAnimatedRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 1),
      reverseTransitionDuration: const Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) =>
          AddNoteScreen(onClosePage: () {}),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
