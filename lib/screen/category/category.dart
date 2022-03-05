import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            title: Text(
              'Categories',
              style: TextStyle(color: theme.colorScheme.secondary),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.add,
                    color: theme.colorScheme.secondary,
                  ))
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
          const Text('You have 4 categories.'),
          const SizedBox(height: 200),
          const Text(
            'Not Implemented yet .',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
          )
        ],
      ),
    );
  }
}
