import 'package:flutter/material.dart';

class SmallNoteItem extends StatelessWidget {
  const SmallNoteItem({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(right: 12, left: 12),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title Title Title',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'School cat.',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black54),
                ),
                Text(
                  '2022/19/02',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54),
                ),
              ],
            )
          ],
        ),
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
