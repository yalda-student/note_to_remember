import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' as drift;
import 'package:yalda_students_notes/common/const.dart';
import 'package:yalda_students_notes/common/lang.dart';
import 'package:yalda_students_notes/data/drift_config.dart';
import 'package:yalda_students_notes/data/source/database.dart';
import 'package:yalda_students_notes/route_generator.dart';
import 'package:yalda_students_notes/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/screen/category/category.dart';
import 'package:yalda_students_notes/screen/category_notes/bloc/category_notes_bloc.dart';
import 'package:yalda_students_notes/screen/home/home_screen.dart';
import 'package:yalda_students_notes/screen/note/bloc/notelist_bloc.dart';
import 'package:yalda_students_notes/screen/search/search_screen.dart';
import 'package:yalda_students_notes/screen/setting/setting_screen.dart';
import 'package:yalda_students_notes/translation/codegen_loader.g.dart';
import 'package:yalda_students_notes/util/theme_util.dart';
import 'package:yalda_students_notes/widgets/bottom_navigation.dart';

const int homeIndex = 0;
const int searchIndex = 1;
const int categoryIndex = 2;
const int settingIndex = 3;
const double bottomNavigationHeight = 65;

void main() async {
  DriftConfig.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  String? languageCode = await getLanguageCode();
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? true;

    runApp(
      EasyLocalization(
        path: 'asset/translation',
        supportedLocales: languagesMap.keys.toList(),
        fallbackLocale: const Locale('fa'),
        useOnlyLangCode: true,
        assetLoader: const CodegenLoader(),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeNotifier>(
                create: (_) =>
                    ThemeNotifier(darkModeOn ? darkTheme : lightTheme)),
            ChangeNotifierProvider<AppDatabase>(
                create: (context) => AppDatabase()),
            BlocProvider<CategoryBloc>(
                create: (context) => CategoryBloc(
                    context.read<AppDatabase>(), const CategoryCompanion())),
            BlocProvider<NoteListBloc>(
                create: (context) => NoteListBloc(context.read<AppDatabase>())),
            BlocProvider<CategoryNotesBloc>(
              create: (context) =>
                  CategoryNotesBloc(appDatabase: context.read<AppDatabase>()),
            )
          ],
          child: MyApp(languageCode: languageCode),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final String? languageCode;

  const MyApp({Key? key, this.languageCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final languageCode =
        EasyLocalization.of(context)!.currentLocale!.languageCode;

    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: const MainScreen(),
      initialRoute: AppConstants.homeRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      locale: Locale(languageCode),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
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
    settingIndex: _settingKey,
  };

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _categoryKey = GlobalKey();
  final GlobalKey<NavigatorState> _settingKey = GlobalKey();

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
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      isFirstTime().then((isFirstTime) {
        if (isFirstTime) {
          createNoneCategory();
        }
      });
    });
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
                    _navigator(_homeKey, homeIndex, const HomeScreen()),
                    _navigator(_searchKey, searchIndex, const SearchScreen()),
                    _navigator(
                        _categoryKey, categoryIndex, const CategoryScreen()),
                    _navigator(
                        _settingKey, settingIndex, const SettingScreen()),
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

  Future<bool> isFirstTime() async {
    final pref = await SharedPreferences.getInstance();
    var isFirstTime = pref.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      pref.setBool('first_time', false);
      return false;
    } else {
      pref.setBool('first_time', false);
      return true;
    }
  }

  void createNoneCategory() async {
    await context.read<AppDatabase>().addCategory(
          CategoryCompanion(
              title: const drift.Value('None'),
              createdAt: drift.Value(DateTime.now())),
        );
  }
}
