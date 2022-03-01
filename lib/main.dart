import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/data/drift_config.dart';
import 'package:yalda_students_notes/data/repo/repositpry.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/data/source/note_data_source.dart';

import 'package:yalda_students_notes/screen/home/home.dart';

void main() async {
  DriftConfig.init();
  runApp(ChangeNotifierProvider<Repository<NoteCompanion>>(
    child: const MyApp(),
  
    create: (context) => Repository<NoteCompanion>(
      NoteDataSource(),
    ),
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
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white),
        ),
        home: const HomeScreen());
  }
}
