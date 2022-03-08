part of 'editnote_bloc.dart';

@immutable
abstract class EditNoteEvent {}

class EditNoteStart extends EditNoteEvent {}

class EditNoteUpdate extends EditNoteEvent {}

class EditNoteDelete extends EditNoteEvent {}

class EditNoteColorChange extends EditNoteEvent {
  final Color color;

  EditNoteColorChange(this.color);
}
