import 'package:flutter/material.dart';

class AppPopupMenuItem extends StatelessWidget {

  final IconData icon;
  final String title;

  const AppPopupMenuItem({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 6),
         Icon(icon, color: Colors.black),
        const SizedBox(width: 6),
        Text(title, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}

