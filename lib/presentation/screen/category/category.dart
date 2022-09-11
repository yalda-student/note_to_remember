import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/category/ext.dart';
import 'package:yalda_students_notes/presentation/widgets/category_dialog.dart';
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
      height: context.singleChildScrollViewDynamicHeight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _AppBar(theme: theme),
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
    return ListTile(
      title: Text(
        LocaleKeys.listCategories.tr(),
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
      leading: Icon(Iconsax.note_2, color: theme.colorScheme.secondary),
      trailing: IconButton(
        onPressed: () => _showDialog(context, theme),
        icon: Icon(Iconsax.add_circle, color: theme.colorScheme.secondary),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context, ThemeData theme) async {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.onPrimary.withOpacity(0.15), width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.new_category.tr()),
          content: SingleChildScrollView(
              child: CategoryDialog(outlineInputBorder: outlineInputBorder)),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _CategoryList(data: data)),
              Text(
                  '${LocaleKeys.category_count_1.tr()} ${data.length} ${LocaleKeys.category_count_2.tr()}'),
              const SizedBox(height: 20),
            ],
          ));
        } else {
          return const InvalidState();
        }
      },
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<CategoryModel> data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.only(top: AppPadding.p16),
          child: ResponsiveGridView.builder(
            itemCount: data.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            gridDelegate: const ResponsiveGridDelegate(
                maxCrossAxisExtent: 160,
                childAspectRatio: 0.9,
                crossAxisSpacing: ValueManager.gridSpacing,
                mainAxisSpacing: ValueManager.gridSpacing),
            itemBuilder: (context, index) =>
                CategoryItem(categoryData: data[index]),
          ),
        );
      },
    );
  }
}
