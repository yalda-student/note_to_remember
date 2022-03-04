import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: const Text('setting'),
      ),
    );
  }
}