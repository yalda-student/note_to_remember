import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/screen/category_notes/category_notes.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';

class CategoryItem extends StatelessWidget {
  final Color color;
  final CategoryModel categoryData;

  const CategoryItem(
      {Key? key, required this.color, required this.categoryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryNotesScreen(category: categoryData),
            ));
      },
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
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: color.withOpacity(0.25),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Iconsax.folder_25, color: color, size: 80),
            Text(categoryData.title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(
              '${categoryData.numberOfNotes} ${LocaleKeys.note.tr()}',
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
