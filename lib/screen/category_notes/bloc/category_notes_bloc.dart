import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';

part 'category_notes_event.dart';
part 'category_notes_state.dart';

class CategoryNotesBloc extends Bloc<CategoryNotesEvent, CategoryNotesState> {
  final AppDatabase appDatabase;
  final int categoryId;
  CategoryNotesBloc({required this.appDatabase, required this.categoryId})
      : super(CategoryNotesInitial()) {
    on<CategoryNotesEvent>((event, emit) async {
      if (event is CategoryNoteStart) {
        final list = await appDatabase.getNotesInCategory(categoryId);
        if (list.isNotEmpty) {
          // emit(CategoryNotesSuccess(list));
        } else {
          emit(CategoryNotesEmptyState());
        }
      }
    });
  }
}
