part of 'editnote_bloc.dart';

@immutable
abstract class EditNoteState {
  final NoteModel noteData;

  const EditNoteState(this.noteData);
}

class EditNoteInitial extends EditNoteState {
  const EditNoteInitial(NoteModel noteData) : super(noteData);
}

class EditNoteLoading extends EditNoteState {
  const EditNoteLoading(NoteModel noteData) : super(noteData);
}
