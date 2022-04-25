import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';

class AppIcons {
  final IconData backIcon;

  final IconData moreIcon;

  AppIcons({required this.backIcon, required this.moreIcon});
}

class RIcons extends AppIcons {
  RIcons()
      : super(
          backIcon: Iconsax.arrow_circle_right,
          moreIcon: Iconsax.arrow_circle_left,
        );
}

class LIcons extends AppIcons {
  LIcons()
      : super(
          backIcon: Iconsax.arrow_circle_left,
          moreIcon: Iconsax.arrow_circle_right,
        );
}
