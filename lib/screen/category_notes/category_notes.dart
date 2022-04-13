import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/screen/category_notes/bloc/category_notes_bloc.dart';
import 'package:yalda_students_notes/widgets/empty_state.dart';
import 'package:yalda_students_notes/widgets/loading_state.dart';
import 'package:yalda_students_notes/widgets/note_list.dart';

class CategoryNotesScreen extends StatelessWidget {
  final String categoryTitle;

  const CategoryNotesScreen({
    Key? key,
    required this.categoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //view notes and rename category

    final theme = Theme.of(context);
    
    return Scaffold(
        body: Column(
      children: [
        AppBar(
            title: Text(
              categoryTitle,
              style: TextStyle(color: theme.colorScheme.secondary),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_circle_left, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            )),
        const Divider(),
        Consumer<AppDatabase>(
          builder: (context, value, child) {
            context.read<CategoryNotesBloc>().add(CategoryNoteStart());
            return BlocBuilder<CategoryNotesBloc, CategoryNotesState>(
              builder: (context, state) {
                return _handleStates(state);
              },
            );
          },
        )
      ],
    ));
  }

  _handleStates(CategoryNotesState state) {
    if (state is CategoryNotesLoading || state is CategoryNotesInitial) {
      return const Center(child: Text('Loading'));
    } else if (state is CategoryNotesEmptyState) {
      return const EmptyState();
    } else if (state is CategoryNotesSuccess) {
      return NoteList(data: state.data);
    } else {
      return const Center(
        child: Text('Invalid State'),
      );
    }
  }
}
