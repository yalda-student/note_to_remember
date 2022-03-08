import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'editnote_event.dart';
part 'editnote_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  NoteData _noteData;
  final AppDatabase database;

  EditNoteBloc(this.database, this._noteData)
      : super(EditNoteInitial(_noteData)) {
    on<EditNoteEvent>((event, emit) async {
      if (event is EditNoteUpdate) {
        _updateNote(event, emit);
      } else if (event is EditNoteDelete) {
        _deleteNote(event, emit);
      } else if (event is EditNoteColorChange) {
        _noteData = NoteData(
            id: _noteData.id,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            color: event.color.value,
            isFavorite: _noteData.isFavorite);

        emit(EditNoteInitial(_noteData));
      }
    });
  }

  void _deleteNote(EditNoteDelete event, Emitter<EditNoteState> emit) {
    database.deleteNote(_noteData.id);
  }

  void _updateNote(EditNoteUpdate event, Emitter<EditNoteState> emit) {
    database.updateNote(_noteData);
  }
}
