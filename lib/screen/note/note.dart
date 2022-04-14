import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/screen/add_note/add_note_screen.dart';
import 'package:yalda_students_notes/screen/add_note/bloc/addnote_bloc.dart';
import 'package:yalda_students_notes/screen/note/bloc/notelist_bloc.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/widgets/empty_state.dart';
import 'package:yalda_students_notes/widgets/loading_state.dart';
import 'package:yalda_students_notes/widgets/note_list.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<NoteListBloc>(
      create: (context) => NoteListBloc(context.read<AppDatabase>()),
      child: Stack(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  LocaleKeys.notesList.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ),
                leading: Icon(
                  Iconsax.note_21,
                  color: theme.colorScheme.secondary,
                ),
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
          Positioned(
            bottom: 16,
            right: 8,
            child: FloatingActionButton(
              onPressed: () {
                _openAddNotePage(context);
              },
              child: Icon(Iconsax.add, color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _handleStates(NoteListState state) {
    if (state is NoteListSuccess) {
      return NoteList(data: state.noteList);
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
    final _note = NoteCompanion(
      title: const drift.Value(''),
      color: drift.Value(Colors.white.value),
      createdAt: drift.Value(DateTime.now()),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BlocProvider<AddNoteBloc>(
          create: (context) => AddNoteBloc(context.read<AppDatabase>(), _note),
          child: const AddNoteScreen(),
        ),
      ),
    );
  }
}
