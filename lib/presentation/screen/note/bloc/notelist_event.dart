part of 'notelist_bloc.dart';

@immutable
abstract class NoteListEvent {}

class NoteListStart extends NoteListEvent {}

class NoteListStar extends NoteListEvent {
  final NoteModel noteData;

  NoteListStar(this.noteData);
}
