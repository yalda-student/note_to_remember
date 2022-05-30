import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/gen/assets.gen.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/main.dart';
import 'package:yalda_students_notes/presentation/resources/color_manager.dart';
import 'package:yalda_students_notes/presentation/resources/style_manager.dart';
import 'package:yalda_students_notes/presentation/screen/setting/setting_dialog.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  AppDrawer({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double width = min(context.screenWidth * 0.3, 250);
    return Container(
      width: width,
      height: context.screenHeight,
      alignment: Alignment.center,
      color: theme.colorScheme.onSecondary.withOpacity(0.9),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Assets.icon.icon.image(
                width: ResponsiveValue<double>(context,
                    defaultValue: 105,
                    valueWhen: [
                      const Condition.equals(name: TABLET, value: 75)
                    ]).value,
                color: theme.colorScheme.onSurface),
            SizedBox(height: context.screenWidth * 0.02),
            Text(LocaleKeys.note_to_remember.tr()),
            SizedBox(height: context.screenWidth * 0.02),
            const Divider(),
            SizedBox(height: context.screenWidth * 0.02),
            _DrawerItem(
              title: LocaleKeys.new_note.tr(),
              activeIconData: Iconsax.note_add5,
              inactiveIconData: Iconsax.note_add,
              isActive: selectedIndex == newNoteIndex,
              onTap: () => onTap(newNoteIndex),
            ),
            _DrawerItem(
                title: LocaleKeys.notes.tr(),
                activeIconData: Iconsax.note_15,
                inactiveIconData: Iconsax.note_1,
                isActive: selectedIndex == homeIndex,
                onTap: () => onTap(homeIndex)),
            _DrawerItem(
                title: LocaleKeys.favorite_Notes.tr(),
                activeIconData: Iconsax.heart5,
                inactiveIconData: Iconsax.heart,
                isActive: selectedIndex == favoriteIndex,
                onTap: () => onTap(favoriteIndex)),
            _DrawerItem(
                title: LocaleKeys.search.tr(),
                activeIconData: Iconsax.search_normal_15,
                inactiveIconData: Iconsax.search_normal_1,
                isActive: selectedIndex == searchIndex,
                onTap: () => onTap(searchIndex)),
            _DrawerItem(
                title: LocaleKeys.categories.tr(),
                activeIconData: Iconsax.category_25,
                inactiveIconData: Iconsax.category_2,
                isActive: selectedIndex == categoryIndex,
                onTap: () => onTap(categoryIndex)),
            _DrawerItem(
                title: LocaleKeys.setting.tr(),
                activeIconData: Iconsax.setting_25,
                inactiveIconData: Iconsax.setting_2,
                isActive: selectedIndex == settingIndex,
                onTap: () => _showDialog(context, theme)),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context, ThemeData theme) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => settingDialog(context, theme),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData activeIconData;
  final IconData inactiveIconData;
  final bool isActive;
  final Function() onTap;

  const _DrawerItem(
      {Key? key,
      required this.title,
      required this.activeIconData,
      required this.inactiveIconData,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      tileColor: isActive ? ColorManager.radioButtonColor : null,
      onTap: () => onTap(),
      title: Text(title, style: StyleManager.drawerTextStyle(context)),
      leading: Icon(isActive ? activeIconData : inactiveIconData,
          size: ResponsiveValue<double>(context,
                  defaultValue: 20,
                  valueWhen: [const Condition.equals(name: TABLET, value: 18)])
              .value,
          color: isActive
              ? ColorManager.radioButtonColor
              : theme.colorScheme.onSurface),
    );
  }
}
