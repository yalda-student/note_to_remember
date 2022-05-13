import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
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
      closedShape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      closedElevation: 0,
      openElevation: 20,
      transitionDuration:
          const Duration(milliseconds: AppConstants.openAnimationDuration),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      openBuilder: (context, openContainer) =>
          CategoryNotesScreen(category: categoryData),
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: ()=> openContainer.call(),
          onDoubleTap: () {
            //delete category
            if (categoryData.id != 1) {
              context.read<CategoryBloc>().add(CategoryDelete(categoryData.id));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(LocaleKeys.delete_none_category.tr()),
                ),
              );
            }
          },
          child: Container(
            height: 40,
            width:  40,
            decoration: BoxDecoration(
                color: Color(categoryData.color).withOpacity(0.25),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Iconsax.folder_25,
                    color: Color(categoryData.color), size: 65),
                Text(categoryData.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                Text(
                  '${categoryData.numberOfNotes} ${LocaleKeys.note.tr()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 13),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
