import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/core/data/model/note_model.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';

part 'searchnote_event.dart';

part 'searchnote_state.dart';

class SearchNoteBloc extends Bloc<SearchNoteEvent, SearchNoteState>{
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
    _database.getAllNotes(keyword: expression).then((value) {
      try {
        if (value.isEmpty) {
          emit(SearchNoteEmpty());
        } else {
          emit(SearchNoteSuccess(value));
        }
      } catch (e) {
        emit(SearchNoteError('Error'));
      }
    });
  }
}
