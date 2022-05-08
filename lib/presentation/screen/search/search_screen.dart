import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/screen/search/bloc/searchnote_bloc.dart';
import 'package:yalda_students_notes/presentation/widgets/empty_state.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';
import 'package:yalda_students_notes/presentation/widgets/note_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          SearchNoteBloc(NoteRepository(context.read<AppDatabase>())),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: BlocBuilder<SearchNoteBloc, SearchNoteState>(
          builder: (ctx, state) {
            return Column(
              children: [
                _searchTextField(ctx, theme),
                const Divider(),
                _handleStates(theme, state),
              ],
            );
          },
        )),
      ),
    );
  }

  Container _searchTextField(BuildContext ctx, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: LocaleKeys.search.tr(),
          icon: Icon(
            Iconsax.search_normal,
            color: theme.colorScheme.secondary,
          ),
        ),
        textInputAction: TextInputAction.search,
        onChanged: (term) {
          if (term.isNotEmpty) {
            ctx.read<SearchNoteBloc>().add(SearchNoteTextChange(term));
          } else {
            ctx.read<SearchNoteBloc>().add(SearchNoteClearText());
          }
        },
      ),
    );
  }

  Widget _handleStates(ThemeData theme, SearchNoteState state) {
    if (state is SearchNoteEmpty) {
      return const EmptyState();
    } else if (state is SearchNoteSuccess) {
      return NoteList(data: state.list);
    } else if (state is SearchNoteLoading) {
      return const LoadingState();
    } else if (state is SearchNoteInitial) {
      return _initialState(theme);
    } else {
      return const Text('Invalid state');
    }
  }

  Column _initialState(ThemeData theme) {
    return Column(
      children: [
        const SizedBox(height: 150),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_rounded,
              size: 35,
              color: Colors.black54,
            ),
            Text(
              LocaleKeys.startSearching,
              style: theme.textTheme.headline4,
            ).tr(),
          ],
        ),
      ],
    );
  }
}
