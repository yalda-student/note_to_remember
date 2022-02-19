import 'package:flutter/material.dart';

class SmallNoteItem extends StatelessWidget {
  const SmallNoteItem({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color.withOpacity(0.5)),
      child: Column(
        children: [
          const Text(
            'Title',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('School cat.'),
              Text('2020/19/02'),
            ],
          )
        ],
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  const NoteItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
