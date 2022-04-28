import 'package:hive_flutter/adapters.dart';
import 'package:yalda_students_notes/core/data/datasource/local/hive_db.dart';

const categoryBox = "CATEGORIES_BOX";
const favoriteNoteBox = "FAVORITE_NOTE_BOX";
const sharedStore = "SHARED_STORE";

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapter();
    await _unBoxing();
  }
  //remove future for testing
  static Future<void> _unBoxing() async {
    await Hive.openBox(sharedStore);
    await Hive.openLazyBox(categoryBox);
  }
  static void _registerAdapter(){
    // Hive.registerAdapter(PokemonAdapter());
    // Hive.registerAdapter(PokemonInfoAdapter());
  }

  //lazy initialization
  static late HiveDb? _db;
  static HiveDb get hiveDb => _db ??= HiveDb();
}
