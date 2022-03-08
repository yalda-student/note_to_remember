import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/screen/search/bloc/searchnote_bloc.dart';
import 'package:yalda_students_notes/widgets/empty_state.dart';
import 'package:yalda_students_notes/widgets/note_list.dart';

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
      create: (context) => SearchNoteBloc(context.read<AppDatabase>()),
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
          hintText: 'Search',
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
      return const Center(
        child: CircularProgressIndicator(),
      );
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
              'Start searching',
              style: theme.textTheme.headline4,
            ),
          ],
        ),
      ],
    );
  }
}
