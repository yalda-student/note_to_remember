import 'dart:math';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/data/datasource/database.dart';
import 'package:yalda_students_notes/data/model/note_model.dart';
import 'package:yalda_students_notes/data/repository/note_repository.dart';
import 'package:yalda_students_notes/gen/assets.gen.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/main.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';
import 'package:yalda_students_notes/presentation/screen/add_note/add_note_screen.dart';
import 'package:yalda_students_notes/presentation/screen/add_note/bloc/addnote_bloc.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  const AppDrawer({
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
      color: theme.colorScheme.onSecondary.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: context.screenHeight * 0.3,
            child: DrawerHeader(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Assets.icon.icon
                      .image(width: 100, color: theme.colorScheme.onSurface),
                  Text(LocaleKeys.note_to_remember.tr()),
                  SizedBox(height: context.screenHeight * 0.02),
                ],
              )),
            ),
          ),
          _DrawerItem(
            title: LocaleKeys.new_note.tr(),
            activeIconData: Iconsax.note_add5,
            inactiveIconData: Iconsax.note_add,
            isActive: selectedIndex == newNoteIndex,
            onTap: () => onTap(newNoteIndex),
            // onTap: () => _openAddNotePage(context),
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
              onTap: () => onTap(settingIndex)),
          SizedBox(height: context.screenHeight * 0.15)
        ],
      ),
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
    return ListTile(
      tileColor: isActive ? Theme.of(context).colorScheme.secondary : null,
      onTap: () => onTap(),
      title: Text(title, style: FontManager.drawerTextStyle(context)),
      leading: Icon(isActive ? activeIconData : inactiveIconData, size: 20),
    );
  }
}
