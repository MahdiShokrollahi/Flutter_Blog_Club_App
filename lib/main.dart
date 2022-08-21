import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blogclub/constants/constants.dart';
import 'package:flutter_blogclub/screens/article.dart';
import 'package:flutter_blogclub/screens/home_screen.dart';
import 'package:flutter_blogclub/screens/profile.dart';
import 'package:flutter_blogclub/screens/splash_screen.dart';

import 'gen/fonts.gen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              primary: primarycolor,
              onPrimary: Colors.white,
              onSurface: primarytextcolor,
              background: Color(0xffFBFCFF),
              surface: Colors.white,
              onBackground: primarytextcolor),
          appBarTheme: AppBarTheme(
              foregroundColor: primarytextcolor,
              backgroundColor: Theme.of(context).colorScheme.surface,
              titleSpacing: 32,
              elevation: 0),
          snackBarTheme: SnackBarThemeData(backgroundColor: primarycolor),
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: FontFamily.avenir,
                  color: primarytextcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              headline4: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 24,
                  color: primarytextcolor,
                  fontWeight: FontWeight.w700),
              headline5: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              subtitle1: TextStyle(
                  fontFamily: FontFamily.avenir,
                  color: secondrytextcolor,
                  fontSize: 18,
                  fontWeight: FontWeight.w200),
              subtitle2: TextStyle(
                  fontFamily: FontFamily.avenir,
                  color: primarytextcolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              bodyText2: TextStyle(
                  fontSize: 12,
                  fontFamily: FontFamily.avenir,
                  color: secondrytextcolor),
              bodyText1: TextStyle(
                  fontSize: 14,
                  fontFamily: FontFamily.avenir,
                  color: primarytextcolor),
              caption: TextStyle(
                  fontFamily: FontFamily.avenir,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff7B8BB2)))),
      // home: Stack(
      //   children: [
      //     Positioned.fill(child: HomeScreen()),
      //     Positioned(
      //       bottom: 0,
      //       left: 0,
      //       right: 0,
      //       child: bottomNavigation(),
      //     )
      //   ],
      // ),
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const int homeIndex = 0;
const int articleIndex = 1;
const int searchIndex = 2;
const int profileIndex = 3;
const double bottonNavigationHeight = 65;

class _MainScreenState extends State<MainScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> history = [];

  GlobalKey<NavigatorState> homeKey = GlobalKey();
  GlobalKey<NavigatorState> articlekey = GlobalKey();
  GlobalKey<NavigatorState> searchkey = GlobalKey();
  GlobalKey<NavigatorState> profilekey = GlobalKey();

  late final map = {
    homeIndex: homeKey,
    articleIndex: articlekey,
    searchIndex: searchkey,
    profileIndex: profilekey
  };

  Future<bool> onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = history.last;
        history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              bottom: bottonNavigationHeight,
              child: IndexedStack(
                index: selectedScreenIndex,
                children: [
                  navigator(homeKey, homeIndex, HomeScreen()),
                  navigator(articlekey, articleIndex, ArticleScreen()),
                  navigator(searchkey, searchIndex, SearchScreen()),
                  navigator(profilekey, profileIndex, ProfileScreen())
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: bottomNavigation(
                onTap: (int index) {
                  setState(() {
                    history.remove(selectedScreenIndex);
                    history.add(selectedScreenIndex);
                    selectedScreenIndex = index;
                  });
                },
                selectedIndex: selectedScreenIndex,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)),
          );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Search Screen'),
      ),
    );
  }
}

class bottomNavigation extends StatelessWidget {
  const bottomNavigation(
      {Key? key, required this.onTap, required this.selectedIndex})
      : super(key: key);
  final Function(int index) onTap;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 65,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color(0xff9b8487).withOpacity(0.3), blurRadius: 20)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  bottomNavigationItems(
                    imageFileName: 'Home.png',
                    activeIconFileName: 'HomeActive.png',
                    title: 'Home',
                    onTap: () {
                      onTap(homeIndex);
                    },
                    isActive: selectedIndex == homeIndex,
                  ),
                  bottomNavigationItems(
                    imageFileName: 'Articles.png',
                    activeIconFileName: 'ArticlesActive.png',
                    title: 'Articles',
                    onTap: () {
                      onTap(articleIndex);
                    },
                    isActive: selectedIndex == articleIndex,
                  ),
                  Expanded(child: Container()),
                  bottomNavigationItems(
                    imageFileName: 'Search.png',
                    activeIconFileName: 'SearchActive.png',
                    title: 'Search',
                    onTap: () {
                      onTap(searchIndex);
                    },
                    isActive: selectedIndex == searchIndex,
                  ),
                  bottomNavigationItems(
                    imageFileName: 'Menu.png',
                    activeIconFileName: 'MenuActive.png',
                    title: 'Menu',
                    onTap: () {
                      onTap(profileIndex);
                    },
                    isActive: selectedIndex == profileIndex,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              height: 85,
              width: 65,
              alignment: Alignment.topCenter,
              child: Container(
                height: bottonNavigationHeight,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    color: Color(0xff376AED),
                    borderRadius: BorderRadius.circular(32.5)),
                child: Image.asset('assets/img/icons/plus.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class bottomNavigationItems extends StatelessWidget {
  const bottomNavigationItems(
      {Key? key,
      required this.title,
      required this.imageFileName,
      required this.activeIconFileName,
      required this.onTap,
      required this.isActive})
      : super(key: key);

  final String title;
  final String imageFileName;
  final String activeIconFileName;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/icons/${isActive ? activeIconFileName : imageFileName}',
              height: 30,
              width: 30,
            ),
            SizedBox(height: 4),
            Text(title,
                style: themeData.textTheme.caption!.apply(
                    color: isActive
                        ? themeData.colorScheme.primary
                        : themeData.textTheme.caption!.color)),
          ],
        ),
      ),
    );
  }
}
