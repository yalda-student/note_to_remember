import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/common/app.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'starrednotes_event.dart';

part 'starrednotes_state.dart';

class StarredNotesBloc extends Bloc<StarredNotesEvent, StarredNotesState>
    with FetchNote {
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
    try {
      final data = await database.getStarNotes().first;

      if (data.isEmpty) {
        emit(StarredNotesEmpty());
      } else {
        final noteList = fetchNoteData(database, data);
        emit(StarredNotesSuccess(noteList));
      }
    } catch (e) {
      emit(StarredNotesError('Error'));
    }
  }
}
