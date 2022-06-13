import 'package:yalda_students_notes/domain/model/note_model.dart';

abstract class INoteRepository {
  Future insertNote(NoteModel note);

  Future<void> updateNote(NoteModel note);

  Future<void> deleteNote(int id);

  Future getNoteById(int id);

  Future<List<NoteModel>> getAllNotes({String searchKeyword = ''});

  Future<List<NoteModel>> getStarredNotes();

  Future<List<NoteModel>> getNotesInCategory(int categoryId);
}