import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/repository/note_repository_impl.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';

part 'searchnote_event.dart';
part 'searchnote_state.dart';

class SearchNoteBloc extends Bloc<SearchNoteEvent, SearchNoteState> {
  final NoteRepository _repository;

  SearchNoteBloc(this._repository) : super(SearchNoteInitial()) {
    on<SearchNoteEvent>((event, emit) async {
      if (event is SearchNoteTextChange) {
        emit(SearchNoteLoading());
        await _initialList(emit, event.expression);
      } else if (event is SearchNoteClearText) {
        emit(SearchNoteInitial());
      }
    });
  }

  Future<void> _initialList(
      Emitter<SearchNoteState> emit, String expression) async {
    try {
      final data = await _repository.getAllNotes(searchKeyword: expression);
      if (data.isEmpty) {
        emit(SearchNoteEmpty());
      } else {
        emit(SearchNoteSuccess(data));
      }
    } catch (e) {
      emit(SearchNoteError('Error'));
    }
  }
}
