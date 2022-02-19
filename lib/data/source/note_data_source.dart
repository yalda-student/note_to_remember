import 'package:hive_flutter/hive_flutter.dart';
import 'package:yalda_students_notes/data/source/source.dart';
import 'package:yalda_students_notes/model/note.dart';

class NoteDataSource implements DataSource<Note> {
  final Box<Note> box;

  NoteDataSource(this.box);

  @override
  Future<Note> createOrUpdate(Note note) async {
    if (note.isInBox) {
      note.save();
    } else {
      note.id = await box.add(note);
    }
    return note;
  }

  @override
  Future<void> delete(Note note) {
    return note.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(id) {
    return box.delete(id);
  }

  @override
  Future<List<Note>> getData({String keyword = ''}) async {
    if (keyword.isEmpty) {
      return box.values.toList();
    } else {
      return box.values
          .where((note) =>
              note.title.contains(keyword) || note.content.contains(keyword))
          .toList();
    }
  }
}
