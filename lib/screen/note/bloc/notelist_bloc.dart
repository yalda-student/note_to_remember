import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'notelist_event.dart';
part 'notelist_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final AppDatabase database;

  NoteListBloc(this.database) : super(NoteListInitial()) {
    on<NoteListEvent>((event, emit) async {
      debugPrint('sdfsdvsdvasv  NoteListBloc');
      if (event is NoteListStar) {
        await database.updateNote(event.noteData);
        add(NoteListStart());
      }

      if (event is NoteListStart) {
        emit(NoteListLoading());
        await _initialList(emit);
      }
    });
  }

  Future<void> _initialList(Emitter<NoteListState> emit) async {
    try {
      final isEmpty = await database.getAllNotes().isEmpty;
      if (isEmpty) {
        emit(NoteListEmpty());
      } else {
        final noteList = await database.getAllNotes().first;
         debugPrint('$noteList');
        emit(NoteListSuccess(noteList));
      }
    } catch (e) {
      emit(NoteListError('Error'));
    }
  }
}
