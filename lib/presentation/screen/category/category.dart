import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/datasource/shared_pref.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
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
          const Divider(),
          Align(
            alignment: SharedPref.getLanguage().isLanguageRtl()
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p16,
                  top: AppPadding.p16,
                  right: AppPadding.p16),
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
      title: Text(LocaleKeys.categories.tr()),
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
          color: theme.colorScheme.onPrimary.withOpacity(0.15), width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.onSecondary,
          title: Text(LocaleKeys.new_category.tr()),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
          padding: const EdgeInsets.only(top: 16),
          child: ResponsiveGridView.builder(
            itemCount: data.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            gridDelegate: const ResponsiveGridDelegate(
                crossAxisSpacing: 20.0,
                maxCrossAxisExtent: 160,
                mainAxisSpacing: 20.0),
            itemBuilder: (context, index) =>
                CategoryItem(categoryData: data[index]),
          ),
        );
      },
    );
  }
}
