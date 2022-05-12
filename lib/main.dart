import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yalda_students_notes/core/common/app.dart';
import 'package:yalda_students_notes/core/common/app_providers.dart';
import 'package:yalda_students_notes/core/common/const.dart';
import 'package:yalda_students_notes/core/common/lang.dart';
import 'package:yalda_students_notes/data/drift_config.dart';
import 'package:yalda_students_notes/gen/translation/codegen_loader.g.dart';
import 'package:yalda_students_notes/presentation/screen/category/category.dart';
import 'package:yalda_students_notes/presentation/screen/home/home_screen.dart';
import 'package:yalda_students_notes/presentation/screen/onboarding/onboard_screen.dart';
import 'package:yalda_students_notes/presentation/screen/search/search_screen.dart';
import 'package:yalda_students_notes/presentation/screen/setting/setting_screen.dart';
import 'package:yalda_students_notes/presentation/util/theme_util.dart';
import 'package:yalda_students_notes/presentation/widgets/bottom_navigation.dart';
import 'package:yalda_students_notes/presentation/widgets/loading_state.dart';
import 'core/app_model.dart';

const int homeIndex = 0;
const int searchIndex = 1;
const int categoryIndex = 2;
const int settingIndex = 3;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DriftConfig.init();

  SharedPreferences.getInstance().then((prefs) {
    final darkModeOn = prefs.getBool('darkMode') ?? false;

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
                  create: (_) =>
                      ThemeNotifier(darkModeOn ? darkTheme : lightTheme)),
            ),
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

    bool touchMode = context.select((AppModel m) => m.touchMode);
    double densityAmt = touchMode ? 0.0 : -1.0;
    VisualDensity density =
        VisualDensity(horizontal: densityAmt, vertical: densityAmt);

    return MaterialApp(
      title: 'My Notes',
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme().copyWith(visualDensity: density),
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
  Widget build(BuildContext context) {
    final largeScreen = isLargeScreen(context);

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
              if (!largeScreen)
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
