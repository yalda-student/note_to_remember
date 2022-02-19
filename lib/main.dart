import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/data/repo/repositpry.dart';
import 'package:yalda_students_notes/data/source/note_data_source.dart';
import 'package:yalda_students_notes/model/note.dart';
import 'package:yalda_students_notes/screen/home/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(AppConstants.noteBoxName);
  await Hive.openBox<Note>(AppConstants.categoryBoxName);

  runApp(ChangeNotifierProvider<Repository<Note>>(
    child: const MyApp(),
    create: (context) =>
        Repository<Note>(NoteDataSource(Hive.box(AppConstants.noteBoxName))),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            primaryContainer: Color(0xffe8ebed),
            secondary: Color(0xff010101),
          ),
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white)),
      home: const HomeScreen()
    );
  }
}