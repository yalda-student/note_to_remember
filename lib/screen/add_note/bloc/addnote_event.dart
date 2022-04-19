part of 'addnote_bloc.dart';

@immutable
abstract class AddNoteEvent {}

class AddNoteSave extends AddNoteEvent {}

class AddNoteColorChange extends AddNoteEvent {
  final Color color;

  AddNoteColorChange(this.color);
}

class AddNoteContentChange extends AddNoteEvent {
  final String content;

  AddNoteContentChange(this.content);
}

class AddNoteTitleChange extends AddNoteEvent {
  final String title;

  AddNoteTitleChange(this.title);
}

class AddNoteCategoryChange extends AddNoteEvent{

  final CategoryModel category;

  AddNoteCategoryChange(this.category);
}