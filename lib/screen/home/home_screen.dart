import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/screen/favorite/favorite.dart';
import 'package:yalda_students_notes/screen/note/note.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';

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
          AppBar(
            title: Text(LocaleKeys.profileTitle.tr(),
                style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontSize: 22,
                    fontWeight: FontWeight.w600)),
            leading:
                Icon(Iconsax.note_text, color: theme.colorScheme.secondary),
          ),
          const Divider(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ContainedTabBarView(
                  tabs: [
                    const Text(LocaleKeys.notes).tr(),
                    const Text(LocaleKeys.favorite_Notes).tr()
                  ],
                  views: const [
                    NoteScreen(),
                    FavoritePage()
                  ],
                  tabBarViewProperties: const TabBarViewProperties(
                      physics: BouncingScrollPhysics()),
                  tabBarProperties: TabBarProperties(
                      height: 44,
                      width: MediaQuery.of(context).size.width * 0.72,
                      background: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                      indicatorPadding: const EdgeInsets.all(6),
                      position: TabBarPosition.top,
                      alignment: TabBarAlignment.center,
                      indicatorColor: Colors.transparent,
                      labelColor: theme.colorScheme.primary,
                      unselectedLabelColor: theme.colorScheme.onPrimary,
                      indicator: ContainerTabIndicator(
                          color: theme.colorScheme.secondary,
                          radius: BorderRadius.circular(8)))),
            ),
          )
        ],
      ),
    );
  }
}
