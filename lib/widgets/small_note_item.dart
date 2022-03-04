import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:yalda_students_notes/data/source/database.dart';

class SmallNoteItem extends StatelessWidget {
  const SmallNoteItem({Key? key, required this.data}) : super(key: key);

  final NoteData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(data.color).withOpacity(0.85),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 0.2),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(data.color),
                Color(data.color).withOpacity(0.6),
              ])),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  data.isFavorite
                      ? const Icon(Iconsax.star1, color: Colors.amber, size: 20)
                      : const SizedBox()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'School cat.',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.black54),
                ),
                Text(
                  //  DateFormat.yMMMd().format(data.createdAt),
                  DateFormat('dd/MM/yyyy').format(data.createdAt),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
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
