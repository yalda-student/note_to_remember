import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'searchnote_event.dart';

part 'searchnote_state.dart';

class SearchNoteBloc extends Bloc<SearchNoteEvent, SearchNoteState>
    with FetchNote {
  final AppDatabase _database;

  SearchNoteBloc(this._database) : super(SearchNoteInitial()) {
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
      final data = await _database.getAllNotes(keyword: expression).first;
      if (data.isEmpty) {
        emit(SearchNoteEmpty());
      } else {
        final noteList = fetchNoteData(_database, data);
        emit(SearchNoteSuccess(noteList));
      }
    } catch (e) {
      emit(SearchNoteError('Error'));
    }
  }
}
