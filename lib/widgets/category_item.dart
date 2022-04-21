import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/data/model/category_model.dart';
import 'package:yalda_students_notes/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/screen/category_notes/category_notes.dart';

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
      onLongPress: () {
        //delete category
        if (categoryData.id != 1) {
          context.read<CategoryBloc>().add(CategoryDelete(categoryData.id));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("You can't delete None Category."),
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
              '${categoryData.numberOfNotes} Notes',
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
