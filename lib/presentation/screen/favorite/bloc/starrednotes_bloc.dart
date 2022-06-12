import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:yalda_students_notes/data/repository/note_repository_impl.dart';
import 'package:yalda_students_notes/domain/model/note_model.dart';

part 'starrednotes_event.dart';
part 'starrednotes_state.dart';

class StarredNotesBloc extends Bloc<StarredNotesEvent, StarredNotesState> {
  final NoteRepository repository;

  StarredNotesBloc(this.repository) : super(StarredNotesInitial()) {
    on<StarredNotesEvent>((event, emit) async {
      if (event is StarredNotesStart) {
        emit(StarredNotesLoading());
        await _initialList(emit);
      }
    });
  }

  Future<void> _initialList(Emitter<StarredNotesState> emit) async {
    try {
      final data = await repository.getStarredNotes();

      if (data.isEmpty) {
        emit(StarredNotesEmpty());
      } else {
        emit(StarredNotesSuccess(data));
      }
    } catch (e) {
      emit(StarredNotesError('Error'));
    }
  }
}
