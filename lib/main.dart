import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:yalda_students_notes/app/app.dart';
import 'package:yalda_students_notes/app/app_prefs.dart';
import 'package:yalda_students_notes/app/app_providers.dart';
import 'package:yalda_students_notes/app/di.dart';
import 'package:yalda_students_notes/app/global.dart';
import 'package:yalda_students_notes/data/drift_config.dart';
import 'package:yalda_students_notes/gen/translation/codegen_loader.g.dart';
import 'package:yalda_students_notes/presentation/resources/language_manager.dart';
import 'package:yalda_students_notes/presentation/screen/add_note/add_note_screen.dart';
import 'package:yalda_students_notes/presentation/screen/category/category.dart';
import 'package:yalda_students_notes/presentation/screen/favorite/favorite.dart';
import 'package:yalda_students_notes/presentation/screen/home/home_screen.dart';
import 'package:yalda_students_notes/presentation/screen/onboarding/onboard_screen.dart';
import 'package:yalda_students_notes/presentation/screen/search/search_screen.dart';
import 'package:yalda_students_notes/presentation/screen/setting/setting_screen.dart';
import 'package:yalda_students_notes/presentation/util/theme_util.dart';
import 'package:yalda_students_notes/presentation/widgets/bottom_navigation.dart';
import 'package:yalda_students_notes/presentation/widgets/drawer.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';

const int homeIndex = 0;
const int searchIndex = 1;
const int categoryIndex = 2;
const int settingIndex = 3;
const int favoriteIndex = 4;
const int newNoteIndex = 5;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DriftConfig.init();
  await initAppModule();

  final appPref = instance<AppPreferences>();
  final darkModeOn = await appPref.getTheme();
  final appTheme = darkModeOn ? darkTheme : lightTheme;

  // debugPrint('getTheme: $appTheme');
  // debugPrint('lightTheme: $lightTheme');
  // debugPrint('darkTheme: $darkTheme');
  // debugPrint('dark: $darkModeOn');

  runApp(
    EasyLocalization(
      path: 'asset/gen.translation',
      supportedLocales: languagesMap.keys.toList(),
      fallbackLocale: const Locale('fa'),
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: MultiProvider(
        providers: providerList
          ..add(
            ChangeNotifierProvider<ThemeNotifier>(
                create: (_) => ThemeNotifier(appTheme)),
          ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final currentLocale = EasyLocalization.of(context)!.currentLocale!;
    appLocale = currentLocale;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'My Notes',
      builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          breakpoints: const [
            ResponsiveBreakpoint.resize(300, name: MOBILE),
            ResponsiveBreakpoint.autoScale(650, name: TABLET),
            ResponsiveBreakpoint.resize(850, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: FutureBuilder<bool>(
          future: isFirstTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingState();
            }
            if (snapshot.data! && !kIsWeb) {
              return OnBoardingScreen();
            } else {
              return const MainScreen();
            }
          }),
      locale: Locale(currentLocale.languageCode),
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
    favoriteIndex: _favoriteKey,
    newNoteIndex: _newNoteKey,
  };

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _searchKey = GlobalKey();
  final GlobalKey<NavigatorState> _categoryKey = GlobalKey();
  final GlobalKey<NavigatorState> _settingKey = GlobalKey();
  final GlobalKey<NavigatorState> _favoriteKey = GlobalKey();
  final GlobalKey<NavigatorState> _newNoteKey = GlobalKey();

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
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.center,
            layout: ResponsiveWrapper.of(context).isSmallerThan(TABLET)
                ? ResponsiveRowColumnType.COLUMN
                : ResponsiveRowColumnType.ROW,
            children: [
              ResponsiveRowColumnItem(
                columnOrder: 1,
                child: Expanded(
                  child: IndexedStack(
                    index: selectedScreenIndex,
                    children: [
                      _navigator(_homeKey, homeIndex, const HomeScreen()),
                      _navigator(_searchKey, searchIndex, const SearchScreen()),
                      _navigator(
                          _categoryKey, categoryIndex, const CategoryScreen()),
                      _navigator(
                          _settingKey, settingIndex, const SettingScreen()),
                      _navigator(
                          _favoriteKey, favoriteIndex, const FavoriteScreen()),
                      _navigator(_newNoteKey, newNoteIndex,
                          AddNoteScreen(onClosePage: onItemTap)),
                    ],
                  ),
                ),
              ),
              ResponsiveRowColumnItem(
                rowOrder: 0,
                child: ResponsiveVisibility(
                  hiddenWhen: const [Condition.largerThan(name: MOBILE)],
                  replacement: AppDrawer(
                    selectedIndex: selectedScreenIndex,
                    onTap: (index) => onItemTap(index),
                  ),
                  child: CustomBottomNavigation(
                    selectedIndex: selectedScreenIndex,
                    onTap: (index) => onItemTap(index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemTap(int index) {
    setState(() {
      _history.remove(selectedScreenIndex);
      _history.add(selectedScreenIndex);
      selectedScreenIndex = index;
    });
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
