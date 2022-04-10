import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/widgets/category_item.dart';
import 'package:yalda_students_notes/widgets/loading_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
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
          const _CategoryData(),
        ],
      ),
    );
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
          onPressed: () {},
          icon: Icon(
            Iconsax.add_circle,
            color: theme.colorScheme.secondary,
          ),
        )
      ],
    );
  }
}

class _CategoryData extends StatelessWidget {
  const _CategoryData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoryBloc>().add(CategoryStart());
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
                        color: categoryColors[
                            index.remainder(categoryColors.length)],
                        categoryData: data[index],
                      ),
                    ),
                  ),
                  Text('You have ${data.length} categories.'),
                ]),
          );
        } else {
          return const Text('Invalid State');
        }
      },
    );
  }
}
