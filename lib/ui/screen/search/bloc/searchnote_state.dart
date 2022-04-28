part of 'searchnote_bloc.dart';

@immutable
abstract class SearchNoteState {}

class SearchNoteInitial extends SearchNoteState {}

class SearchNoteSuccess extends SearchNoteState {
  final List<NoteModel> list;

  SearchNoteSuccess(this.list);
}

class SearchNoteEmpty extends SearchNoteState {}

class SearchNoteError extends SearchNoteState {
  final String errorMessage;

  SearchNoteError(this.errorMessage);
}

class SearchNoteLoading extends SearchNoteState {}
