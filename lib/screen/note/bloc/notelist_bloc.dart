import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'notelist_event.dart';
part 'notelist_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final AppDatabase database;

  NoteListBloc(this.database) : super(NoteListInitial()) {
    on<NoteListEvent>((event, emit) async {
      if (event is NoteListStar) {
        await database.updateNote(event.noteData);
        add(NoteListStart());
      }

      if (event is NoteListStart) {
        emit(NoteListLoading());
        try {
          final isEmpty = await database.getAllNotes().isEmpty;
          if (isEmpty) {
            emit(NoteListEmpty());
          } else {
            final noteList = await database.getAllNotes().first;
            emit(NoteListSuccess(noteList));
          }
        } catch (e) {
          emit(NoteListError('Error'));
        }
      }
    });
  }
}
