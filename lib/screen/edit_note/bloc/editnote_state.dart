part of 'editnote_bloc.dart';

@immutable
abstract class EditNoteState {
  final NoteData noteData;

  const EditNoteState(this.noteData);
}

class EditNoteInitial extends EditNoteState {
  const EditNoteInitial(NoteData noteData) : super(noteData);
}

class EditNoteLoading extends EditNoteState {
  const EditNoteLoading(NoteData noteData) : super(noteData);
}
