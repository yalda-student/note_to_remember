import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isActive;
  final Function() onTap;

  const DrawerItem(
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

/*
          DrawerItem(
              title: 'title',
              iconData: Iconsax.setting_2,
              isActive: true,
              onTap: onTap(settingIndex))
 */