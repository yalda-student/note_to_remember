part of 'addnote_bloc.dart';

@immutable
abstract class AddNoteState {
  final NoteModel noteData;

  const AddNoteState(this.noteData);
}

class AddNoteInitial extends AddNoteState {
  const AddNoteInitial(NoteModel noteData) : super(noteData);
}
