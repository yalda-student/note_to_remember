import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yalda_students_notes/common/app.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'notelist_event.dart';

part 'notelist_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> with FetchNote {
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
    try {
      final data = await database.getAllNotes().first;
      if (data.isEmpty) {
        emit(NoteListEmpty());
      } else {
        final noteList = fetchNoteData(database, data);
        emit(NoteListSuccess(noteList));
      }
    } catch (e) {
      emit(NoteListError('Error'));
    }
  }
}
