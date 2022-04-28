import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' as drift;
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/core/common/lang.dart';
import 'package:yalda_students_notes/core/data/config/hive/hiveConfig.dart';
import 'package:yalda_students_notes/core/data/datasource/local/sqlite3_db.dart';
import 'package:yalda_students_notes/app/route_generator.dart';
import 'package:yalda_students_notes/ui/screen/category/bloc/category_bloc.dart';
import 'package:yalda_students_notes/ui/screen/home/home_screen.dart';
import 'package:yalda_students_notes/gen/translation/codegen_loader.g.dart';
import 'package:yalda_students_notes/ui/widgets/bottom_navigation.dart';
import 'package:yalda_students_notes/ui/widgets/loading_state.dart';

import '../core/util/pref_helper.dart';
import '../core/util/theme_util.dart';
import '../ui/screen/category/category.dart';
import '../ui/screen/category_notes/bloc/category_notes_bloc.dart';
import '../ui/screen/note/bloc/notelist_bloc.dart';
import '../ui/screen/onboarding/bloc/language_bloc.dart';
import '../ui/screen/onboarding/onboard_screen.dart';
import '../ui/screen/search/search_screen.dart';
import '../ui/screen/setting/setting_screen.dart';

const int homeIndex = 0;
const int searchIndex = 1;
const int categoryIndex = 2;
const int settingIndex = 3;

void main() async {
  await PrefHelper.init();

  PrefHelper.setIsWeb(kIsWeb);
  if (kIsWeb) {
    HiveConfig.init();
  }

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? false;

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
              create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
            ),
            ChangeNotifierProvider<AppDatabase>(
              create: (context) => AppDatabase(),
            ),
            BlocProvider<CategoryBloc>(
              create: (context) => CategoryBloc(
                context.read<AppDatabase>(),
                const CategoryCompanion(),
              ),
            ),
            BlocProvider<NoteListBloc>(
              create: (context) => NoteListBloc(
                context.read<AppDatabase>(),
              ),
            ),
            BlocProvider<LanguageBloc>(
              create: (context) => LanguageBloc(),
            ),
            BlocProvider<CategoryNotesBloc>(
              create: (context) => CategoryNotesBloc(
                appDatabase: context.read<AppDatabase>(),
              ),
            )
          ],
          child: const MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final languageCode =
        EasyLocalization.of(context)!.currentLocale!.languageCode;

    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: FutureBuilder<bool>(
          future: isFirstTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingState();
            }
            if (snapshot.data!) {
              return const OnBoardingScreen();
            } else {
              return const MainScreen();
            }
          }),
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

    Timer(const Duration(seconds: 1), () {
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
                bottom: AppConstants.bottomNavigationHeight,
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

  void createNoneCategory() async {
    await context.read<AppDatabase>().addCategory(
          CategoryCompanion(
              title: const drift.Value('None'),
              createdAt: drift.Value(DateTime.now())),
        );
  }
}