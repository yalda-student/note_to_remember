part of 'notelist_bloc.dart';

@immutable
abstract class NoteListState {}

class NoteListInitial extends NoteListState {}

class NoteListEmpty extends NoteListState {}

class NoteListLoading extends NoteListState {}

class NoteListSuccess extends NoteListState {
  final List<NoteModel> noteList;

  NoteListSuccess(this.noteList);
}

class NoteListError extends NoteListState {
  final String errorMessage;

  NoteListError(this.errorMessage);
}
