part of 'addnote_bloc.dart';

@immutable
abstract class AddNoteState {
  final NoteCompanion noteData;

  const AddNoteState(this.noteData);
}

class AddNoteInitial extends AddNoteState {
  const AddNoteInitial(NoteCompanion noteData) : super(noteData);
}
