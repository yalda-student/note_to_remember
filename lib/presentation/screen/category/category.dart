import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/data/datasource/drift/database.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/widgets/category_item.dart';
import 'package:yalda_students_notes/presentation/widgets/invalid_state.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
        child: SizedBox(
      height: MediaQuery.of(context).size.height - 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _AppBar(theme: theme),
          const Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 16),
              child: Text(LocaleKeys.listCategories.tr(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
          Consumer<AppDatabase>(
            builder: (context, value, child) {
              context.read<CategoryBloc>().add(CategoryStart());
              return const _CategoryData();
            },
          )
        ],
      ),
    ));
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key, required this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.categories.tr(),
        style: TextStyle(color: theme.colorScheme.secondary),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _showDialog(context, theme),
          icon: Icon(
            Iconsax.add_circle,
            color: theme.colorScheme.secondary,
          ),
        )
      ],
    );
  }

  Future<void> _showDialog(BuildContext context, ThemeData theme) async {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.onPrimary.withOpacity(0.5), width: 2.0),
      borderRadius: BorderRadius.circular(12.0),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Category'),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    maxLength: 255,
                    decoration: InputDecoration(
                        hintText: 'Category',
                        filled: true,
                        fillColor: theme.colorScheme.surface.withOpacity(0.5),
                        enabledBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        contentPadding: const EdgeInsets.all(10.0)),
                    onChanged: (value) {
                      context
                          .read<CategoryBloc>()
                          .add(CategoryTextFieldChange(value));
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                LocaleKeys.cancel.tr(),
                style: TextStyle(
                    color: theme.colorScheme.secondary.withOpacity(0.7)),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                LocaleKeys.create.tr(),
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
              onPressed: () {
                context.read<CategoryBloc>().add(CategoryInsert());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _CategoryData extends StatelessWidget {
  const _CategoryData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading || state is CategoryInitial) {
          return const LoadingState();
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        } else if (state is CategorySuccess) {
          List<CategoryModel> data = state.data;
          return Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 430,
                    child: GridView.builder(
                      itemCount: data.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0),
                      itemBuilder: (context, index) => CategoryItem(
                        color: generateColor(),
                        categoryData: data[index],
                      ),
                    ),
                  ),
                  Text(
                      '${LocaleKeys.category_count_1.tr()} ${data.length} ${LocaleKeys.category_count_2.tr()}'),
                ]),
          );
        } else {
          return const InvalidState();
        }
      },
    );
  }
}
