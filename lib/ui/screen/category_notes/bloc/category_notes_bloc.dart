import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';

part 'category_notes_event.dart';

part 'category_notes_state.dart';

class CategoryNotesBloc extends Bloc<CategoryNotesEvent, CategoryNotesState> {
  late int categoryId;
  late CategoryData data;
  final AppDatabase appDatabase;

  CategoryNotesBloc({required this.appDatabase})
      : super(CategoryNotesInitial()) {
    on<CategoryNotesEvent>((event, emit) async {
      if (event is CategoryNoteStart) {
        categoryId = event.categoryId;

        final title = await appDatabase.getCategoryTitle(categoryId);
        emit(CategoryNotesName(title));
        final list = await appDatabase.getNotesInCategory(categoryId);
        if (list.isNotEmpty) {
          emit(CategoryNotesSuccess(list));
        } else {
          emit(CategoryNotesEmptyState());
        }
      } else if (event is CategoryNoteTextFieldChange) {
        data = CategoryData(
            id: categoryId,
            title: event.categoryTitle,
            createdAt: DateTime.now());
      } else if (event is CategoryNoteRename) {
        await appDatabase.updateCategory(data);
      }
    });
  }
}
