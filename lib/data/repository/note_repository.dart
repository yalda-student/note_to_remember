import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';

abstract class INoteRepository {
  Future insertNote(NoteModel note);

  Future<void> updateNote(NoteModel note);

  Future<void> deleteNote(int id);

  Future getNoteById(int id);

  Future<List<NoteModel>> getAllNotes({String searchKeyword = ''});

  Future<List<NoteModel>> getStarredNotes();

  Future<List<NoteModel>> getNotesInCategory(int categoryId);
}

class NoteRepository implements INoteRepository {
  final AppDatabase datasource;

  NoteRepository(this.datasource);

  @override
  Future insertNote(NoteModel note) {
    return datasource.insertNote(note);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    return datasource.updateNote(note);
  }

  @override
  Future<void> deleteNote(int id) {
    return datasource.deleteNote(id);
  }

  @override
  Future<List<NoteModel>> getAllNotes({String searchKeyword = ''}) {
    return datasource.getAllNotes(searchKeyword);
  }

  @override
  Future getNoteById(int id) {
    return datasource.getNoteById(id);
  }

  @override
  Future<List<NoteModel>> getNotesInCategory(int categoryId) async {
    return datasource.getNotesInCategory(categoryId);
  }

  @override
  Future<List<NoteModel>> getStarredNotes() {
    return datasource.getStarNotes();
  }
}
