import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/repository/note_repository_impl.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';

part 'addnote_event.dart';
part 'addnote_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NoteModel _noteData;
  final NoteRepository repository;

  AddNoteBloc(this.repository, this._noteData)
      : super(AddNoteInitial(_noteData)) {
    on<AddNoteEvent>((event, emit) async {
      if (event is AddNoteSave) {
        if (_noteData.title.isEmpty) {
          _noteData.title = getFirstWord(_noteData.content);
        }
        await repository.insertNote(_noteData);
      } else if (event is AddNoteColorChange) {
        _noteData.colorIndex = event.colorIndex;

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteTitleChange) {
        _noteData.title = event.title;

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteCategoryChange) {
        _noteData.category = event.category.title;
        _noteData.categoryId = event.category.id;

        emit(AddNoteInitial(_noteData));
      } else if (event is AddNoteContentChange) {
        _noteData.content = event.content;

        emit(AddNoteInitial(_noteData));
      }
    });
  }

  String getFirstWord(String inputString) {
    List<String> wordList = inputString.split(' ');
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return ' ';
    }
  }
}
