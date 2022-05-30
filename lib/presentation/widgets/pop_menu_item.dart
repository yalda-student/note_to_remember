import 'package:flutter/material.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';

class AppPopupMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const AppPopupMenuItem({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: AppSize.s6),
        Icon(icon, color: Colors.black, size: AppSize.s20),
        const SizedBox(width: AppSize.s6),
        Text(title,
            style:
                const TextStyle(color: Colors.black, fontSize: FontSize.s13)),
      ],
    );
  }
}
