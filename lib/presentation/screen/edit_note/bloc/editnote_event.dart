part of 'editnote_bloc.dart';

@immutable
abstract class EditNoteEvent {}

class EditNoteStart extends EditNoteEvent {}

class EditNoteUpdate extends EditNoteEvent {}

class EditNoteDelete extends EditNoteEvent {}

class EditNoteShare extends EditNoteEvent {}

class EditNoteTitleChange extends EditNoteEvent {
  final String title;

  EditNoteTitleChange(this.title);
}

class EditNoteContentChange extends EditNoteEvent {
  final String content;

  EditNoteContentChange(this.content);
}

class EditNoteColorChange extends EditNoteEvent {
  final int colorIndex;

  EditNoteColorChange(this.colorIndex);
}

class EditNoteCategoryChange extends EditNoteEvent {
  final CategoryModel category;

  EditNoteCategoryChange(this.category);
}
