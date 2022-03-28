import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/round_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yalda_students_notes/screen/favorite/favorite.dart';
import 'package:yalda_students_notes/screen/note/note.dart';
import 'package:yalda_students_notes/translation/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  final int pageCount = 2;
  final PageController _controller = PageController(initialPage: 0);
  final CustomTabBarController _tabBarController = CustomTabBarController();

  HomeScreen({Key? key}) : super(key: key);

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
          Wrap(
            children: [
              Container(
                // width: 100,
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(20)),
                child: CustomTabBar(
                  width: 300,
                  height: 35,
                  itemCount: pageCount,
                  builder: getTabbarChild,
                  tabBarController: _tabBarController,
                  indicator: RoundIndicator(
                    color: theme.colorScheme.secondary,
                    top: 2.5,
                    bottom: 2.5,
                    left: 2.5,
                    right: 2.5,
                    height: 100,
                    radius: BorderRadius.circular(10),
                  ),
                  pageController: _controller,
                ),
              )
            ],
          ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pageCount,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: getTabbarPage(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getTabbarPage(int index) {
    switch (index) {
      case 0:
        return const NotePage();
      case 1:
        return const FavoritePage();
      default:
        return const SizedBox();
    }
  }

  Widget getTabbarChild(BuildContext context, int index) {
    final theme = Theme.of(context);
    return TabBarItem(
      index: index,
      transform: ColorsTransform(
        highlightColor: theme.colorScheme.primary,
        normalColor: theme.colorScheme.onPrimary,
        builder: (context, color) {
          return Container(
            height: 100,
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            alignment: Alignment.center,
            child: Text(
              getTabbarTitle(context, index),
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  String getTabbarTitle(BuildContext context, int index) {
    switch (index) {
      case 0:
        return LocaleKeys.notes.tr();
      case 1:
        return LocaleKeys.favorite_Notes.tr();
      default:
        return '';
    }
  }
}
