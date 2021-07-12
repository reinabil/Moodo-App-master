import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/bloc/themeBloc.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/favPage.dart';
import 'package:moodo/view/homePage.dart';
import 'package:moodo/view/listDoaPage.dart';
import 'package:moodo/view/pagiPetang.dart';

Color colorSolid(LinearGradient theme) =>
    (theme == Style().gradasiPink || theme == Style().gradasiPink2)
        ? Colors.red
        : (theme == Style().gradasiBiru || theme == Style().gradasiBiru2)
            ? Colors.blue
            : (theme == Style().gradasiUngu || theme == Style().gradasiUngu2)
                ? Colors.purple
                : (theme == Style().gradasiOrange ||
                        theme == Style().gradasiOrange2)
                    ? Colors.yellow
                    : Colors.teal;

Color colorAccent(LinearGradient theme) =>
    (theme == Style().gradasiPink || theme == Style().gradasiPink2)
        ? Colors.redAccent
        : (theme == Style().gradasiBiru || theme == Style().gradasiBiru2)
            ? Colors.blueAccent
            : (theme == Style().gradasiUngu || theme == Style().gradasiUngu2)
                ? Colors.purpleAccent
                : (theme == Style().gradasiOrange ||
                        theme == Style().gradasiOrange2)
                    ? Colors.orangeAccent
                    : Colors.tealAccent;

Color colorActive(LinearGradient theme) =>
    (theme == Style().gradasiPink || theme == Style().gradasiPink2)
        ? Colors.redAccent
        : (theme == Style().gradasiBiru || theme == Style().gradasiBiru2)
            ? Colors.blueAccent
            : (theme == Style().gradasiUngu || theme == Style().gradasiUngu2)
                ? Colors.purpleAccent
                : (theme == Style().gradasiOrange ||
                        theme == Style().gradasiOrange2)
                    ? Colors.orangeAccent
                    : Colors.teal;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<StatefulWidget> pages = [
    HomePage(),
    ListDoaPage(),
    PagiPetangPage(),
    FavPage()
  ];

  PageController controller = PageController();

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, LinearGradient>(
      builder: (context, theme) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Moodo",
            theme: ThemeData(
                // Define the default brightness and colors.
                primaryColor: colorSolid(theme),
                accentColor: colorAccent(theme)),
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: DoubleBackToCloseApp(
                snackBar: SnackBar(
                  content: Text(
                    "Tap back again to exit",
                    style: TextStyle(
                      color: colorSolid(theme),
                      fontFamily: "Poppins",
                      fontSize: 14,
                    ),
                  ),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.white,
                  elevation: 2.0,
                  margin: EdgeInsets.only(bottom: 33, left: 16, right: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
                ),
                child: Scaffold(
                  extendBody: true,
                  body: PageView.builder(
                      itemCount: 4,
                      controller: controller,
                      onPageChanged: (page) {
                        setState(() {
                          _selectedIndex = page;
                        });
                      },
                      itemBuilder: (context, position) {
                        return pages[position];
                      }),
                  bottomNavigationBar: BlocBuilder<ThemeBloc, LinearGradient>(
                    builder: (context, theme) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(bottom: 24, right: 8, left: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            gradient: theme,
                            borderRadius: BorderRadius.circular(64),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.white,
                                  offset: Offset(0, 0))
                            ]),
                        child: SafeArea(
                            child: GNav(
                                // curve: Curves.fastOutSlowIn,
                                rippleColor: colorAccent(theme),
                                hoverColor: colorAccent(theme),
                                gap: 0,
                                activeColor: colorActive(theme),
                                iconSize: 24,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 12),
                                duration: Duration(milliseconds: 800),
                                tabBackgroundColor: Colors.white,
                                tabs: [
                                  GButton(
                                      icon: Icons.home_rounded,
                                      iconColor: Colors.white,
                                      text: ' Home',
                                      textStyle: TextStyle(
                                        color: colorActive(theme),
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                      )),
                                  GButton(
                                    icon: Icons.search,
                                    iconColor: Colors.white,
                                    text: ' Cari doa',
                                    textStyle: TextStyle(
                                      color: colorActive(theme),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  ),
                                  GButton(
                                    icon: Icons.wb_sunny,
                                    iconColor: Colors.white,
                                    text: ' Pagi - Petang',
                                    textStyle: TextStyle(
                                      color: colorActive(theme),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  ),
                                  GButton(
                                    icon: Icons.favorite_outlined,
                                    iconColor: Colors.white,
                                    text: ' Favorite',
                                    textStyle: TextStyle(
                                      color: colorActive(theme),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                                selectedIndex: _selectedIndex,
                                onTabChange: (index) {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  controller.jumpToPage(index);
                                })),
                      );
                    },
                  ),
                ),
              ),
            ));
      },
    );
  }
}
