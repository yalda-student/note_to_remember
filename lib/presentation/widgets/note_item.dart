import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animations/animations.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';
import 'package:yalda_students_notes/presentation/screen/edit_note/bloc/editnote_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/edit_note/edit_note_screen.dart';
import 'package:yalda_students_notes/presentation/screen/note/bloc/notelist_bloc.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({Key? key, required this.noteItem, required this.data})
      : super(key: key);

  final NoteModel data;
  final Widget noteItem;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: true,
      closedElevation: 0,
      openElevation: 20,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      transitionType: ContainerTransitionType.fade,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      transitionDuration:
          const Duration(milliseconds: AppConstants.openAnimationDuration),
      openBuilder: (context, openContainer) {
        return BlocProvider<EditNoteBloc>(
          create: (context) =>
              EditNoteBloc(NoteRepository(context.read<AppDatabase>()), data),
          child: const EditNoteScreen(),
        );
      },
      closedBuilder: (context, openContainer) {
        return InkWell(
          child: noteItem,
          onTap: () => openContainer.call(),
          onDoubleTap: () => starNote(context),
        );
      },
    );
  }

  void starNote(BuildContext context) {
    final note = data;
    context.read<NoteListBloc>().add(
          NoteListStar(
            NoteModel(
                id: note.id,
                title: note.title,
                content: note.content,
                createdAt: note.createdAt,
                color: note.color,
                isFavorite: !note.isFavorite,
                categoryId: note.categoryId),
          ),
        );
  }
}
