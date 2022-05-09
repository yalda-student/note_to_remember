import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';

part 'notelist_event.dart';

part 'notelist_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final NoteRepository repository;

  NoteListBloc(this.repository) : super(NoteListInitial()) {
    on<NoteListEvent>((event, emit) async {
      if (event is NoteListStar) {
        await repository.updateNote(event.noteData);
      }

      if (event is NoteListStart) {
        emit(NoteListLoading());
        await _initialList(emit);
      }
    });
  }

  Future<void> _initialList(Emitter<NoteListState> emit) async {
    try {
      final data = await repository.getAllNotes(searchKeyword: '');
      if (data.isEmpty) {
        emit(NoteListEmpty());
      } else {
        emit(NoteListSuccess(data));
      }
    } catch (e) {
      debugPrint('$e');
      emit(NoteListError(e.toString()));
    }
  }
}
