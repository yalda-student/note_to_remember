import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //appBar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(),
              Text('Categories'),
              Icon(Iconsax.add),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'List Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Icon(Iconsax.sort)
            ],
          ),
          //todo: GridView
          const Text('You have 4 categories.')
        ],
      ),
    );
  }
}
