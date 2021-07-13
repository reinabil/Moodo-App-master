import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/favPage.dart';
import 'package:moodo/view/homePage.dart';
import 'package:moodo/view/listDoaPage.dart';
import 'package:moodo/view/pagiPetang.dart';

Color _themeSolid(Color color) => (color == Colors.pink)
    ? Colors.red
    : (color == Colors.blue)
        ? Colors.blue
        : (color == Colors.purple)
            ? Colors.purple
            : (color == Colors.orange)
                ? Colors.yellow
                : Colors.teal;

Color _themeActive(Color color) => (color == Colors.pink)
    ? Colors.redAccent
    : (color == Colors.blue)
        ? Colors.blueAccent
        : (color == Colors.purple)
            ? Colors.purple
            : (color == Colors.orange)
                ? Colors.orange.shade900
                : Colors.teal;

LinearGradient _theme(Color color) => (color == Colors.pink)
    ? Style().gradasiPink
    : (color == Colors.blue)
        ? Style().gradasiBiru
        : (color == Colors.purple)
            ? Style().gradasiUngu
            : (color == Colors.orange)
                ? Style().gradasiOrange
                : Style().gradasi;

class MainPage extends StatefulWidget {
  LinearGradient themeData;

  MainPage({required this.themeData});

  @override
  _MainPageState createState() => _MainPageState(themeData: themeData);
}

class _MainPageState extends State<MainPage> {
  LinearGradient themeData;

  _MainPageState({required this.themeData});
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moodo',
      theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Colors.white,
          accentColor: Colors.white),
      home: BlocBuilder<ColorBloc, Color>(
        builder: (context, color) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: DoubleBackToCloseApp(
              snackBar: SnackBar(
                content: Text(
                  "Tap back again to exit",
                  style: TextStyle(
                    color: _themeSolid(color),
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
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      });
                    },
                    itemBuilder: (context, position) {
                      return pages[position];
                    }),
                bottomNavigationBar: BlocBuilder<ColorBloc, Color>(
                  builder: (context, color) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 24, right: 8, left: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          gradient: _theme(color),
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
                              rippleColor: _themeActive(color),
                              hoverColor: _themeActive(color),
                              gap: 0,
                              activeColor: _themeActive(color),
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
                                      color: _themeActive(color),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    )),
                                GButton(
                                  icon: Icons.search,
                                  iconColor: Colors.white,
                                  text: ' Cari doa',
                                  textStyle: TextStyle(
                                    color: _themeActive(color),
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                  ),
                                ),
                                GButton(
                                  icon: Icons.wb_sunny,
                                  iconColor: Colors.white,
                                  text: ' Pagi - Petang',
                                  textStyle: TextStyle(
                                    color: _themeActive(color),
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                  ),
                                ),
                                GButton(
                                  icon: Icons.favorite_outlined,
                                  iconColor: Colors.white,
                                  text: ' Favorite',
                                  textStyle: TextStyle(
                                    color: _themeActive(color),
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
          );
        },
      ),
    );
  }
}
