import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalda_students_notes/app.dart';
import 'package:yalda_students_notes/data/drift_config.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/route_generator.dart';
import 'package:yalda_students_notes/screen/category/category.dart';
import 'package:yalda_students_notes/screen/home/home_screen.dart';
import 'package:yalda_students_notes/screen/search/search_screen.dart';
import 'package:yalda_students_notes/screen/setting/setting_screen.dart';
import 'package:yalda_students_notes/widgets/bottom_navigation.dart';

const int homeIndex = 0;
const int searchIndex = 1;
const int categoryIndex = 2;
const int settinghIndex = 3;
const double bottomNavigationHeight = 65;

void main() async {
  DriftConfig.init();
  runApp(Provider<AppDatabase>(
    child: const MyApp(),
    create: (context) => AppDatabase(),
    dispose: (context, AppDatabase db) {
      db.close();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            primaryContainer: Color(0xffe8ebed),
            secondary: Color(0xff010101),
          ),
          appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white),
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.black,
              selectionColor: Color(0xffc6c8ce),
              selectionHandleColor: Color(0xff626362)),
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(8.0),
          )),
      initialRoute: AppConstants.homeRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;

  final List<int> _history = [];
  late final map = {
    homeIndex: _homeKey,
    searchIndex: _searchKey,
    categoryIndex: _categoryKey,
    settinghIndex: _settinghKey,
  };

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _categoryKey = GlobalKey();
  final GlobalKey<NavigatorState> _settinghKey = GlobalKey();

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                bottom: bottomNavigationHeight,
                child: IndexedStack(
                  index: selectedScreenIndex,
                  children: [
                    _navigator(_homeKey, homeIndex, HomeScreen()),
                    _navigator(_searchKey, searchIndex, const SearchScreen()),
                    _navigator(
                        _categoryKey, categoryIndex, const CategoryScreen()),
                    _navigator(
                        _settinghKey, settinghIndex, const SettingScreen()),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => Offstage(
                offstage: selectedScreenIndex != index,
                child: child,
              ),
            ),
          );
  }
}
