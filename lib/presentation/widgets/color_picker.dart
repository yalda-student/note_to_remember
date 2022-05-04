import 'package:flutter/material.dart';
import 'package:yalda_students_notes/common/color.dart';

class ColorPicker extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const ColorPicker(
      {Key? key, required this.onTap, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.only(left: 6),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: colors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onTap(index);
            },
            child: Stack(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: const EdgeInsets.fromLTRB(6, 4, 0, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: colors[index],
                    border: Border.all(
                        color: Colors.black.withOpacity(0.5), width: 1),
                  ),
                ),
                selectedIndex == index
                    ? Icon(Icons.colorize_rounded,
                        size: 18, color: Colors.black.withOpacity(0.8))
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}
