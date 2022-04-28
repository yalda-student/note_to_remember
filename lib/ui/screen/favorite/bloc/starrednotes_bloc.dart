import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/core/data/model/note_model.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';

part 'starrednotes_event.dart';

part 'starrednotes_state.dart';

class StarredNotesBloc extends Bloc<StarredNotesEvent, StarredNotesState> {
  final AppDatabase database;

  StarredNotesBloc(this.database) : super(StarredNotesInitial()) {
    on<StarredNotesEvent>((event, emit) async {
      if (event is StarredNotesStart) {
        emit(StarredNotesLoading());
        await _initialList(emit);
      }
    });
  }

  Future<void> _initialList(Emitter<StarredNotesState> emit) async {
    database.getStarNotes().then((value) {
      try {
        if (value.isEmpty) {
          emit(StarredNotesEmpty());
        } else {
          emit(StarredNotesSuccess(value));
        }
      } catch (e) {
        emit(StarredNotesError('Error'));
      }
    });
  }
}
