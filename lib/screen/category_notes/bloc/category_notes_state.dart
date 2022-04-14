part of 'category_notes_bloc.dart';

abstract class CategoryNotesState extends Equatable {
  const CategoryNotesState();
}

class CategoryNotesInitial extends CategoryNotesState {
  @override
  List<Object> get props => [];
}

class CategoryNotesLoading extends CategoryNotesState {
  @override
  List<Object> get props => [];
}

class CategoryNotesEmptyState extends CategoryNotesState {
  @override
  List<Object?> get props => [];
}

class CategoryNotesSuccess extends CategoryNotesState {
  final List<NoteModel> data;

  const CategoryNotesSuccess(this.data);

  @override
  List<Object?> get props => [data];
}
