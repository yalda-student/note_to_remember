import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/app.dart';

class NotePage extends StatelessWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'List Notes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Icon(Iconsax.sort)
              ],
            ),
            //todo: note list
          ],
        ),
        Positioned(
          bottom: 8,
          right: 8,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AppConstants.addNoteRoute);
            },
            child: Icon(Iconsax.add, color: theme.colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
