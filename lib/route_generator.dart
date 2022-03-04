import 'package:flutter/material.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/screen/add_note/add_note_screen.dart';
import 'package:yalda_students_notes/screen/home/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppConstants.addNoteRoute:
        return MaterialPageRoute(builder: (_) =>  const AddNoteScreen());
      // case '/edit_employee':
      //   // if (args is int) {
      //   //   return MaterialPageRoute(
      //   //       builder: (_) => EditEmployeeScreen(id: args));
      //   // }
      //   return _errorRoute();

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
