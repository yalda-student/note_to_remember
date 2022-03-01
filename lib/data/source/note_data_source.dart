import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/data/source/source.dart';

class NoteDataSource implements DataSource<NoteCompanion> {

 final s = AppDatabase();

  @override
  Future<int> create(NoteCompanion noteCompanion) async {

    // return await s.into(note).insert(noteCompanion);
     throw UnimplementedError();
  }

  @override
  Future<void> delete(id) {
    throw UnimplementedError();
  }

  @override
  Future<List<NoteCompanion>> getData({String keyword = ''}) {
    throw UnimplementedError();
  }

  @override
  Future<NoteCompanion> update(NoteCompanion data) {
    throw UnimplementedError();
  }

  //search note
  //get note in category
}

// class NoteDataSource implements DataSource<Note> {
//   final Box<Note> box;

//   NoteDataSource(this.box);

//   @override
//   Future<Note> createOrUpdate(Note note) async {
//     if (note.isInBox) {
//       note.save();
//     } else {
//       note.id = await box.add(note);
//     }
//     return note;
//   }

//   @override
//   Future<void> delete(Note note) {
//     return note.delete();
//   }

//   @override
//   Future<void> deleteAll() {
//     return box.clear();
//   }

//   @override
//   Future<void> deleteById(id) {
//     return box.delete(id);
//   }

//   @override
//   Future<List<Note>> getData({String keyword = ''}) async {
//     if (keyword.isEmpty) {
//       return box.values.toList();
//     } else {
//       return box.values
//           .where((note) =>
//               note.title.contains(keyword) || note.content.contains(keyword))
//           .toList();
//     }
//   }
// }
