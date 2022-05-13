import 'dart:math';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/gen/assets.gen.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/main.dart';
import 'package:yalda_students_notes/presentation/resources/font_manager.dart';

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

    double width = min(MediaQuery.of(context).size.width * 0.3, 250);
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height * 0.85,
      color: theme.colorScheme.primary.withOpacity(0.9),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Assets.icon.icon
                      .image(width: 100, color: theme.colorScheme.secondary),
                  Text(LocaleKeys.note_to_remember.tr()),
                ],
              )),
            ),
          ),
          ListTile(
            title: Text(
              LocaleKeys.home.tr(),
              style: FontManager.drawerTextStyle(context),
            ),
            leading: const Icon(Iconsax.home, size: 20),
            onTap: () => onTap(homeIndex),
          ),
          ListTile(
            title: Text(
              LocaleKeys.favorite_Notes.tr(),
              style: FontManager.drawerTextStyle(context),
            ),
            leading: const Icon(Iconsax.heart, size: 20),
            onTap: () => onTap(favoriteIndex),
          ),
          ListTile(
            title: Text(
              LocaleKeys.search.tr(),
              style: FontManager.drawerTextStyle(context),
            ),
            leading: const Icon(Iconsax.search_normal, size: 20),
            onTap: () => onTap(searchIndex),
          ),
          ListTile(
            title: Text(
              LocaleKeys.categories.tr(),
              style: FontManager.drawerTextStyle(context),
            ),
            leading: const Icon(Iconsax.category_2, size: 20),
            onTap: () => onTap(categoryIndex),
          ),
          ListTile(
            title: Text(
              LocaleKeys.setting.tr(),
              style: FontManager.drawerTextStyle(context),
            ),
            leading: const Icon(Iconsax.setting_2, size: 20),
            onTap: () => onTap(settingIndex),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isActive;
  final Function() onTap;

  const _DrawerItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(title),
      leading: Icon(
        iconData,
        color:
            isActive ? theme.colorScheme.primary : theme.colorScheme.onPrimary,
      ),
      onTap: () => onTap,
    );
  }
}
