import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yalda_students_notes/data/repository/note_repository_impl.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';

part 'editnote_event.dart';
part 'editnote_state.dart';

class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  final NoteModel _noteData;
  final NoteRepository repository;

  EditNoteBloc(this.repository, this._noteData)
      : super(EditNoteInitial(_noteData)) {
    on<EditNoteEvent>((event, emit) async {
      if (event is EditNoteUpdate) {
        await repository.updateNote(_noteData);
      } else if (event is EditNoteDelete) {
        await repository.deleteNote(_noteData.id);
      } else if (event is EditNoteCategoryChange) {
        _noteData.categoryId = event.category.id;
        _noteData.category = event.category.title;

        emit(EditNoteInitial(_noteData));
      } else if (event is EditNoteColorChange) {
        _noteData.colorIndex = event.colorIndex;

        emit(EditNoteInitial(_noteData));
      } else if (event is EditNoteTitleChange) {
        _noteData.title = event.title;

        emit(EditNoteInitial(_noteData));
      } else if (event is EditNoteContentChange) {
        _noteData.content = event.content;

        emit(EditNoteInitial(_noteData));
      } else if (event is EditNoteShare) {
        debugPrint('EditNoteShare');
        Share.share('${_noteData.title}\n\n${_noteData.content}');
      }
    });
  }
}
