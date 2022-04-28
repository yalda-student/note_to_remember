import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yalda_students_notes/core/data/model/note_model.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';

part 'notelist_event.dart';

part 'notelist_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final AppDatabase database;

  NoteListBloc(this.database) : super(NoteListInitial()) {
    on<NoteListEvent>((event, emit) async {
      if (event is NoteListStar) {
        await database.updateNote(event.noteData);
      }

      if (event is NoteListStart) {
        emit(NoteListLoading());
        await _initialList(emit);
      }
    });
  }

  Future<void> _initialList(Emitter<NoteListState> emit) async {
    database.getAllNotes().then((value) {
      try {
        if (value.isEmpty) {
          emit(NoteListEmpty());
        } else {
          emit(NoteListSuccess(value));
        }
      } catch (e) {
        emit(NoteListError('Error'));
      }
    });
  }
}
