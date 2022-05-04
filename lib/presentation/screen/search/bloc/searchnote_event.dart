part of 'searchnote_bloc.dart';

@immutable
abstract class SearchNoteEvent {}

class SearchNoteTextChange extends SearchNoteEvent {
  final String expression;

  SearchNoteTextChange(this.expression);
}

class SearchNoteClearText extends SearchNoteEvent {}
