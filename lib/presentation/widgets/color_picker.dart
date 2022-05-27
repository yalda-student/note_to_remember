import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/core/common/util/theme_util.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';

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
        itemCount: ColorManager.noteColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final itemSize = AppSize.colorPickerIconSize(context);
          final themeNotifier = Provider.of<ThemeNotifier>(context);
          final _isDark = (themeNotifier.getTheme() == darkTheme);

          final color = ColorManager.noteColors[index];

          return GestureDetector(
            onTap: () => onTap(index),
            child: Stack(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              children: [
                Container(
                  height: itemSize,
                  width: itemSize,
                  margin: const EdgeInsets.fromLTRB(6, 4, 0, 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(itemSize / 2),
                    color: _isDark ? color.darkColor : color.lightColor,
                    border: Border.all(
                        color:  Colors.grey.withOpacity(0.8), width: 1),
                  ),
                ),
                selectedIndex == index
                    ? Icon(Icons.check,
                        size: AppSize.checkIconSize(context),
                    color: _isDark? Colors.white.withOpacity(0.8) :Colors.black.withOpacity(0.8) )
                    : const SizedBox()
              ],
            ),
          );
        },
      ),
    );
  }
}
