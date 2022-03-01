import 'package:flutter/material.dart';
import 'package:flutter_custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_custom_tab_bar/indicator/custom_indicator.dart';
import 'package:flutter_custom_tab_bar/indicator/round_indicator.dart';
import 'package:flutter_custom_tab_bar/transform/color_transform.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/model/note_data.dart';
import 'package:yalda_students_notes/screen/favorite/favorite.dart';
import 'package:yalda_students_notes/screen/note/note.dart';

const int homeIndex = 0;
const int categoryIndex = 1;
const int settinghIndex = 2;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int pageCount = 2;
  late final PageController _controller = PageController(initialPage: 0);
  final CustomTabBarController _tabBarController = CustomTabBarController();

  int selectedScreenIndex = homeIndex;

  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _categoryKey = GlobalKey();
  final GlobalKey<NavigatorState> _settinghKey = GlobalKey();

  Future<bool> _onWillPop() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // var of = Provider.of<AppDatabase>(context);
    // of.into(Note).insert(NoteCompanion());

    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const _AppBar(),
                    const Divider(),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: CustomTabBar(
                          tabBarController: _tabBarController,
                          height: 35,
                          itemCount: pageCount,
                          builder: getTabbarChild,
                          indicator: RoundIndicator(
                            color: Colors.black87,
                            top: 2.5,
                            bottom: 2.5,
                            left: 2.5,
                            right: 2.5,
                            height: 100,
                            radius: BorderRadius.circular(10),
                          ),
                          pageController: _controller,
                        ),
                      ),
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
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: CustomBottomNavigation(
                    selectedIndex: selectedScreenIndex,
                    onTap: (index) {
                      setState(() {
                        _history.remove(selectedScreenIndex);
                        _history.add(selectedScreenIndex);
                        selectedScreenIndex = index;
                      });
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget getTabbarChild(BuildContext context, int index) {
    return TabBarItem(
      index: index,
      transform: ColorsTransform(
        highlightColor: Colors.white,
        normalColor: Colors.black54,
        builder: (context, color) {
          return Container(
            height: 100,
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            alignment: Alignment.center,
            constraints: const BoxConstraints(minWidth: 60),
            child: Text(
              getTabbarTitle(index),
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

  String getTabbarTitle(int index) {
    switch (index) {
      case 0:
        return 'Notes';
      case 1:
        return 'Favorite Notes';
      default:
        return '';
    }
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
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Iconsax.note_text),
              SizedBox(
                width: 8,
              ),
              Text(
                'My Note',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(children: const [
            Icon(Iconsax.search_status),
            SizedBox(
              width: 8,
            ),
            Icon(Iconsax.direct_normal),
          ])
        ],
      ),
    );
  }
}

//todo: bottom navigation onTap
class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  const CustomBottomNavigation(
      {Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 84,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
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
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.grey.shade800,
      ),
    );
  }
}
