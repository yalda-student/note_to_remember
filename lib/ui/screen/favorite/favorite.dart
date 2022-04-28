import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/ui/widgets/empty_state.dart';
import 'package:yalda_students_notes/ui/widgets/loading_state.dart';
import 'package:yalda_students_notes/ui/widgets/note_list.dart';

import 'bloc/starrednotes_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider<StarredNotesBloc>(
      create: (context) => StarredNotesBloc(context.read<AppDatabase>()),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              LocaleKeys.favorite_Notes,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ).tr(),
            leading: Icon(
              Iconsax.note_favorite,
              color: theme.colorScheme.secondary,
            ),
          ),
          Consumer<AppDatabase>(
            builder: (context, value, child) {
              context.read<StarredNotesBloc>().add(StarredNotesStart());
              return BlocBuilder<StarredNotesBloc, StarredNotesState>(
                builder: (context, state) {
                  return _handleStates(state);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _handleStates(StarredNotesState state) {
    if (state is StarredNotesSuccess) {
      return NoteList(data: state.noteList);
    } else if (state is StarredNotesEmpty) {
      return const EmptyState();
    } else if (state is StarredNotesLoading || state is StarredNotesInitial) {
      return const LoadingState();
    } else if (state is StarredNotesError) {
      return Center(child: Text(state.message));
    } else {
      throw Exception('Invalid State');
    }
  }
}
