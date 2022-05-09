import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/category_repository.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';

part 'category_notes_event.dart';

part 'category_notes_state.dart';

class CategoryNotesBloc extends Bloc<CategoryNotesEvent, CategoryNotesState> {
  late int categoryId;
  late CategoryModel categoryData;
  final NoteRepository noteRepository;
  final CategoryRepository categoryRepository;

  CategoryNotesBloc(
      {required this.categoryRepository, required this.noteRepository})
      : super(CategoryNotesInitial()) {
    on<CategoryNotesEvent>((event, emit) async {
      if (event is CategoryNoteStart) {
        categoryId = event.categoryId;

        final title = await categoryRepository.getCategoryTitle(categoryId);
        emit(CategoryNotesName(title));
        final list = await noteRepository.getNotesInCategory(categoryId);
        if (list.isNotEmpty) {
          emit(CategoryNotesSuccess(list));
        } else {
          emit(CategoryNotesEmptyState());
        }
      } else if (event is CategoryNoteTextFieldChange) {
        categoryData = CategoryModel(
            id: categoryId,
            title: event.categoryTitle,
            color: categoryData.color);
      } else if (event is CategoryNoteRename) {
        await categoryRepository.updateCategory(categoryData);
      }
    });
  }
}
