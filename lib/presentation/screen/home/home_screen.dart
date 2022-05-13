import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/screen/favorite/favorite.dart';
import 'package:yalda_students_notes/presentation/screen/note/note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
              child: ResponsiveVisibility(
                hiddenWhen: const [Condition.largerThan(name: MOBILE)],
                replacement:   const NoteScreen(),
                child: ContainedTabBarView(
                    tabs: [
                      const Text(LocaleKeys.notes).tr(),
                      const Text(LocaleKeys.favorite_Notes).tr()
                    ],
                    views: const [
                      NoteScreen(),
                      FavoriteScreen()
                    ],
                    tabBarViewProperties: const TabBarViewProperties(
                        physics: BouncingScrollPhysics()),
                    tabBarProperties: TabBarProperties(
                        height: 49,
                        width: MediaQuery.of(context).size.width * 0.8,
                        background: Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withOpacity(0.3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                        indicatorPadding:
                            const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        position: TabBarPosition.top,
                        alignment: TabBarAlignment.center,
                        indicatorColor: Colors.transparent,
                        labelColor: theme.colorScheme.primary,
                        unselectedLabelColor: theme.colorScheme.onPrimary,
                        indicator: ContainerTabIndicator(
                            color: theme.colorScheme.secondary,
                            radius: BorderRadius.circular(8)))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
