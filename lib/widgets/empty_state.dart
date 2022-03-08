import 'package:flutter/material.dart';
import 'package:yalda_students_notes/gen/assets.gen.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
           const SizedBox(height: 100),
          Assets.image.error404.image(width: 180, color: Theme.of(context).colorScheme.secondary),
          const Text(
            "You don't have any note.",
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
          )
        ],
      ),
    );
  }
}
