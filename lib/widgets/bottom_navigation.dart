import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/main.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  const CustomBottomNavigation(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: bottomNavigationHeight,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomNavigationItem(
            icon: Iconsax.home,
            isActive: selectedIndex == homeIndex,
            onTap: () {
              onTap(homeIndex);
            },
          ),
          BottomNavigationItem(
            icon: Iconsax.search_status,
            isActive: selectedIndex == searchIndex,
            onTap: () {
              onTap(searchIndex);
            },
          ),
          BottomNavigationItem(
            icon: Iconsax.category_2,
            isActive: selectedIndex == categoryIndex,
            onTap: () {
              onTap(categoryIndex);
            },
          ),
          BottomNavigationItem(
            icon: Iconsax.setting_2,
            isActive: selectedIndex == settinghIndex,
            onTap: () {
              onTap(settinghIndex);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    Key? key,
    required this.icon,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color:
            isActive ? theme.colorScheme.primary : theme.colorScheme.onPrimary,
      ),
    );
  }
}
