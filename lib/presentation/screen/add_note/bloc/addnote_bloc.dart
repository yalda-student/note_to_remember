import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';

part 'addnote_event.dart';

part 'addnote_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  NoteModel _noteData;
  final NoteRepository repository;

  AddNoteBloc(this.repository, this._noteData)
      : super(AddNoteInitial(_noteData)) {
    on<AddNoteEvent>((event, emit) async {
      if (event is AddNoteSave) {
        int id = await repository.insertNote(_noteData);
      } else if (event is AddNoteColorChange) {
        _noteData = NoteModel(
            title: _noteData.title,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            color: event.color.value,
            categoryId: _noteData.categoryId,
            isFavorite: _noteData.isFavorite);

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteTitleChange) {
        _noteData = NoteModel(
            title: event.title,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            color: _noteData.color,
            categoryId: _noteData.categoryId,
            isFavorite: _noteData.isFavorite);

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteCategoryChange) {
        _noteData = NoteModel(
            title: _noteData.title,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            color: _noteData.color,
            categoryId: event.category.id,
            category: event.category.title,
            isFavorite: _noteData.isFavorite);

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteContentChange) {
        _noteData = NoteModel(
            title: _noteData.title,
            content: event.content,
            createdAt: _noteData.createdAt,
            color: _noteData.color,
            categoryId: _noteData.categoryId,
            isFavorite: _noteData.isFavorite);

        emit(AddNoteInitial(_noteData));
      }
    });
  }
}
