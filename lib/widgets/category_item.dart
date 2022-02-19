import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Icon(
            Iconsax.folder,
            color: color,
          ),
          const Text(
            'category name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const Text(
            '19 Notes',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
