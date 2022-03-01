import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Iconsax.folder_25,
            color: color,
            size: 50,
          ),
          const Text(
            'category name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text(
            '19 Notes',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
