part of 'category_notes_bloc.dart';

abstract class CategoryNotesEvent extends Equatable {
  const CategoryNotesEvent();
}

class CategoryNoteStart extends CategoryNotesEvent {
  final int categoryId;

  const CategoryNoteStart(this.categoryId);

  @override
  List<Object?> get props => [];
}

class CategoryNoteTextFieldChange extends CategoryNotesEvent {
  final String categoryTitle;

  const CategoryNoteTextFieldChange(this.categoryTitle);

  @override
  List<Object?> get props => [categoryTitle];
}

class CategoryNoteRename extends CategoryNotesEvent {
  @override
  List<Object?> get props => [];
}
