import 'package:flutter/material.dart';

const colors = <Color>[
  Color(0xffffffff),
  Color(0xffbbdcf8),
  Color(0xffF8CBBB),
  Color(0xfff8f4bb),
  Color(0xffbf8c82),
  Color(0xffc2f8bb),
  Color(0xffbbcef8),
  Color(0xffe1bbf8),
  Color(0xff9dc89f),
  Color(0xffff707e),
  Color(0xffd3fcff),
  Color(0xffc8c09d),
  Color(0xfff8bbe2),
];

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
