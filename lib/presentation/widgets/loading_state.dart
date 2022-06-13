import 'package:flutter/material.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/widgets/bouncing_spinner.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 100,
      child: BouncingSpinner(
        length: 5,
        radius: 25,
        duration: const Duration(seconds: 1),
        color1: Theme.of(context).colorScheme.secondary,
        color2: ColorManager.radioButtonColor,
      ),
    ));
  }
}
