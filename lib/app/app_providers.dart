import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/app/app.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/repository/category_repository_impl.dart';
import 'package:yalda_students_notes/data/repository/note_repository_impl.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/category_notes/bloc/category_notes_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/note/bloc/notelist_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/onboarding/bloc/language_bloc.dart';

final providerList = [
  ChangeNotifierProvider<AppDatabase>(create: (context) => AppDatabase()),
  BlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(
          CategoryRepository(context.read<AppDatabase>()),
          CategoryModel(title: '', color: generateColor()))),
  BlocProvider<NoteListBloc>(
      create: (context) =>
          NoteListBloc(NoteRepository(context.read<AppDatabase>()))),
  BlocProvider<OnBoardingBloc>(create: (context) => OnBoardingBloc()),
  BlocProvider<CategoryNotesBloc>(
    create: (context) => CategoryNotesBloc(
        categoryRepository: CategoryRepository(context.read<AppDatabase>()),
        noteRepository: NoteRepository(context.read<AppDatabase>())),
  )
];
