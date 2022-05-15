import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';

class NoteGridItem extends StatelessWidget {
  final NoteModel data;

  const NoteGridItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(data.color).withOpacity(0.85),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 0.3),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(data.color),
                Color(data.color).withOpacity(0.55),
              ])),
      child: Column(
        children: [
          Text(data.title, style: FontManager.noteTitleTextStyle()),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              data.content,
              maxLines: 4,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
            ),
          ),
          if (data.isFavorite)
            const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Iconsax.heart5, color: Colors.red, size: 20)),
        ],
      ),
    );
  }
}
