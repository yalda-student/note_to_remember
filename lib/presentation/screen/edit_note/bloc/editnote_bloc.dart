import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';

part 'editnote_event.dart';

part 'editnote_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  NoteModel _noteData;
  final NoteRepository repository;

  EditNoteBloc(this.repository, this._noteData)
      : super(EditNoteInitial(_noteData)) {
    on<EditNoteEvent>((event, emit) async {
      if (event is EditNoteUpdate) {
        await repository.updateNote(_noteData);
      } else if (event is EditNoteDelete) {
        await repository.deleteNote(_noteData.id);
      } else if (event is EditNoteCategoryChange) {
        _noteData = NoteModel(
            id: _noteData.id,
            title: _noteData.title,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            colorIndex: _noteData.colorIndex,
            isFavorite: _noteData.isFavorite,
            categoryId: event.category.id,
            category: event.category.title);

        emit(EditNoteInitial(_noteData));
      }
      else if (event is EditNoteColorChange) {
        _noteData = NoteModel(
            id: _noteData.id,
            title: _noteData.title,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            colorIndex: event.colorIndex,
            isFavorite: _noteData.isFavorite,
            categoryId: _noteData.categoryId,
            category: _noteData.category);

        emit(EditNoteInitial(_noteData));
      }
      else if (event is EditNoteTitleChange) {
        _noteData = NoteModel(
            id: _noteData.id,
            title: event.title,
            content: _noteData.content,
            createdAt: _noteData.createdAt,
            colorIndex: _noteData.colorIndex,
            isFavorite: _noteData.isFavorite,
            categoryId: _noteData.categoryId,
            category: _noteData.category);

        emit(EditNoteInitial(_noteData));
      }
      else if (event is EditNoteContentChange) {
        _noteData = NoteModel(
            id: _noteData.id,
            title: _noteData.title,
            content: event.content,
            createdAt: _noteData.createdAt,
            colorIndex: _noteData.colorIndex,
            isFavorite: _noteData.isFavorite,
            categoryId: _noteData.categoryId,
            category: _noteData.category);

        emit(EditNoteInitial(_noteData));
      }
    });
  }
}
