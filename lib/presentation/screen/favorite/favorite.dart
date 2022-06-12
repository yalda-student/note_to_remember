import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/repository/note_repository_impl.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/favorite/bloc/starrednotes_bloc.dart';
import 'package:yalda_students_notes/presentation/widgets/empty_state.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';
import 'package:yalda_students_notes/presentation/widgets/note_grid.dart';
import 'package:yalda_students_notes/presentation/widgets/note_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider<StarredNotesBloc>(
      create: (context) =>
          StarredNotesBloc(NoteRepository(context.read<AppDatabase>())),
      child: Padding(
        padding: const EdgeInsets.only(top: AppPadding.p12),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                LocaleKeys.favorite_Notes,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ).tr(),
              leading: Icon(
                Iconsax.note_favorite,
                color: theme.colorScheme.onSurface,
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
      ),
    );
  }

  Widget _handleStates(StarredNotesState state) {
    if (state is StarredNotesSuccess) {
      return ResponsiveVisibility(
        hiddenWhen: const [Condition.largerThan(name: MOBILE)],
        child: NoteList(data: state.noteList),
        replacement: NoteGrid(data: state.noteList),
      );
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
