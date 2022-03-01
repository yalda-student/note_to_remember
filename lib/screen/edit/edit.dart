import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditNoteScreen extends StatelessWidget {
  const EditNoteScreen({ Key? key }) : super(key: key);

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
        ],
      ),
    );
  }
}