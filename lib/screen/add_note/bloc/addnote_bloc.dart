import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'addnote_event.dart';
part 'addnote_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  NoteCompanion _noteData;
  final AppDatabase database;
  AddNoteBloc(this.database, this._noteData)
      : super(AddNoteInitial(_noteData)) {
    on<AddNoteEvent>((event, emit) async {
      if (event is AddNoteSave) {
        database.addNote(_noteData);
      } else if (event is AddNoteColorChange) {
        _noteData = NoteCompanion(
            title: _noteData.title,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            color: Value(event.color.value),
            isFavorite: _noteData.isFavorite);

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteTitleChange) {
        _noteData = NoteCompanion(
            title: Value(event.title),
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            color: _noteData.color,
            isFavorite: _noteData.isFavorite);

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteContentChange) {
        _noteData = NoteCompanion(
            title: _noteData.title,
            content: Value(event.content),
            createdAt: _noteData.createdAt,
            color: _noteData.color,
            isFavorite: _noteData.isFavorite);

        emit(AddNoteInitial(_noteData));
      }
    });
  }
}
