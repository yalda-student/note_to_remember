import 'package:flutter/material.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/app/main.dart';

import '../ui/screen/add_note/add_note_screen.dart';
import '../ui/screen/edit_note/edit_note_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case AppConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case AppConstants.addNoteRoute:
        return MaterialPageRoute(builder: (_) => const AddNoteScreen());
      case AppConstants.editNoteRoute:
        return MaterialPageRoute(builder: (_) => const EditNoteScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Route'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Sorry, no route was found!',
            style: TextStyle(color: Colors.red, fontSize: 18),
          ),
        ),
      );
    });
  }
}
