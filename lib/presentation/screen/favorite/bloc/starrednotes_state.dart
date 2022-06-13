part of 'starrednotes_bloc.dart';

@immutable
abstract class StarredNotesState {}

class StarredNotesInitial extends StarredNotesState {}

class StarredNotesSuccess extends StarredNotesState {
  final List<NoteModel> noteList;

  StarredNotesSuccess(this.noteList);
}

class StarredNotesEmpty extends StarredNotesState {}

class StarredNotesError extends StarredNotesState {
  final String message;

  StarredNotesError(this.message);
}

class StarredNotesLoading extends StarredNotesState {}
