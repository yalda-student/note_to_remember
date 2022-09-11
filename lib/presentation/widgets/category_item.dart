import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/app/const.dart';
import 'package:yalda_students_notes/domain/model/category_model.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/presentation/screen/category_notes/category_notes.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryData;

  const CategoryItem({Key? key, required this.categoryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: true,
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      transitionType: ContainerTransitionType.fade,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      closedElevation: 0,
      openElevation: 20,
      transitionDuration:
          const Duration(milliseconds: AppConstants.openAnimationDuration),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      openBuilder: (context, openContainer) =>
          CategoryNotesScreen(category: categoryData),
      closedBuilder: (context, openContainer) {
        final categoryColor = Color(categoryData.color);
        return InkWell(
          onTap: () => openContainer.call(),
          onDoubleTap: () => _deleteCategory(context),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p10),
            decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.075),
                border: Border.all(color: categoryColor.withOpacity(0.075)),
                borderRadius: BorderRadius.circular(AppSize.s15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Iconsax.folder_25, color: categoryColor, size: 40),
                Text(categoryData.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: FontSize.s15)),
                Text(
                  '${categoryData.numberOfNotes} ${LocaleKeys.note.tr()}',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: ResponsiveValue(context,
                          defaultValue: FontSize.s13,
                          valueWhen: const [
                            Condition.largerThan(
                                name: MOBILE, value: FontSize.s11),
                          ]).value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteCategory(BuildContext context) {
    if (categoryData.id != 1) {
      context.read<CategoryBloc>().add(CategoryDelete(categoryData.id));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.delete_none_category.tr()),
        ),
      );
    }
  }
}
