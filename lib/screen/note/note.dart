import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/screen/add_note/add_note_screen.dart';
import 'package:yalda_students_notes/screen/note/bloc/notelist_bloc.dart';
import 'package:yalda_students_notes/widgets/empty_state.dart';
import 'package:yalda_students_notes/widgets/note_list.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    debugPrint('note-page build');
    return BlocProvider<NoteListBloc>(
      create: (context) => NoteListBloc(context.read<AppDatabase>()),
      child: Stack(
        children: [
          Column(
            children: [
              ListTile(
                title: const Text(
                  'List Notes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                leading: Icon(
                  Iconsax.note_21,
                  color: theme.colorScheme.secondary,
                ),
              ),
              Consumer<AppDatabase>(
                builder: (context, value, child) {
                  context.read<NoteListBloc>().add(NoteListStart());
                  debugPrint('note-page Consumer');
                  return BlocBuilder<NoteListBloc, NoteListState>(
                   
                      builder: (context, state) {
                    debugPrint('note-page BlocBuilder');
                    return _handleStates(state);
                  },);
                },
              )
            ],
          ),
          Positioned(
            bottom: 16,
            right: 8,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddNoteScreen()),
                );
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
      return const Center(child: CircularProgressIndicator());
    } else if (state is NoteListError) {
      return Center(child: Text(state.errorMessage));
    } else {
      throw Exception('Invalid State');
    }
  }
}
