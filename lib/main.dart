import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/data/drift_config.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/route_generator.dart';

import 'package:yalda_students_notes/screen/home/home.dart';

void main() async {
  DriftConfig.init();
  runApp(Provider<AppDatabase>(
    child: const MyApp(),
    create: (context) => AppDatabase(),
    dispose: (context, AppDatabase db) {
      db.close();
    },
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
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.black,
              selectionColor: Color(0xffc6c8ce),
              selectionHandleColor: Color(0xff626362)),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8.0),
          )),
      initialRoute: AppConstants.homeRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const HomeScreen(),
    );
  }
}
