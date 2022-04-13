part of 'category_notes_bloc.dart';

abstract class CategoryNotesEvent extends Equatable {
  const CategoryNotesEvent();
}

class CategoryNoteStart extends CategoryNotesEvent {
  @override
  List<Object?> get props => [];
}
