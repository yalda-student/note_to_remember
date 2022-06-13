import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';

part 'searchnote_event.dart';
part 'searchnote_state.dart';

class SearchNoteBloc extends Bloc<SearchNoteEvent, SearchNoteState> {
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

  
  Future<void> _initialList(Emitter<SearchNoteState> emit, String expression) async {
    try {
      final isEmpty = await _database.getAllNotes().isEmpty;
      if (isEmpty) {
        emit(SearchNoteEmpty());
      } else {
        final noteList = await _database.getAllNotes(expression).first;
         debugPrint('$noteList');
        emit(SearchNoteSuccess(noteList));
      }
    } catch (e) {
      emit(SearchNoteError('Error'));
    }
  }
}
