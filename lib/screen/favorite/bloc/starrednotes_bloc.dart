import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/source/database.dart';

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
    try {
      final isEmpty = await database.getStarNotes().isEmpty;
      if (isEmpty) {
        emit(StarredNotesEmpty());
      } else {
        final noteList = await database.getStarNotes().first;
        emit(StarredNotesSuccess(noteList));
      }
    } catch (e) {
      emit(StarredNotesError('Error'));
    }
  }
}
