import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/core/common/util/global_exts.dart';
import 'package:yalda_students_notes/gen/translation/locale_keys.g.dart';
import 'package:yalda_students_notes/presentation/resources/value_manager.dart';
import 'package:yalda_students_notes/presentation/screen/favorite/favorite.dart';
import 'package:yalda_students_notes/presentation/screen/note/note.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ResponsiveVisibility(
      hiddenWhen: const [Condition.largerThan(name: MOBILE)],
      replacement: const NoteScreen(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          children: [
            AppBar(
              title: Text(LocaleKeys.profileTitle.tr(),
                  style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 22,
                      fontWeight: FontWeight.w600)),
              leading:
                  Icon(Iconsax.note_text, color: theme.colorScheme.secondary),
            ),
            const Divider(),
            const SizedBox(height: AppSize.s8),
            Expanded(
              child: ContainedTabBarView(
                tabs: [
                  const Text(LocaleKeys.notes).tr(),
                  const Text(LocaleKeys.favorite_Notes).tr()
                ],
                views: const [NoteScreen(), FavoriteScreen()],
                tabBarViewProperties: const TabBarViewProperties(
                    physics: BouncingScrollPhysics()),
                tabBarProperties: TabBarProperties(
                  height: 49,
                  width: context.screenWidth * 0.7,
                  background: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppSize.s12)),
                    ),
                  ),
                  indicatorPadding: const EdgeInsets.fromLTRB(AppPadding.p12,
                      AppPadding.p6, AppPadding.p12, AppPadding.p6),
                  position: TabBarPosition.top,
                  alignment: TabBarAlignment.center,
                  indicatorColor: Colors.transparent,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: theme.colorScheme.onPrimary,
                  indicator: ContainerTabIndicator(
                    color: theme.colorScheme.onSurface,
                    radius: BorderRadius.circular(AppSize.s12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
