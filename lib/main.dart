// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/bloc/favBloc.dart';
import 'package:moodo/model/countBloc.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/mainPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

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

LinearGradient _bg(Color color) => (color == Colors.pink)
    ? Style().gradasiPink
    : (color == Colors.blue)
        ? Style().gradasiBiru2
        : (color == Colors.purple)
            ? Style().gradasiUngu2
            : (color == Colors.orange)
                ? Style().gradasiOrange2
                : Style().gradasi2;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(ProviderScope(child: Moodo()));
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
  ));
}

const LinearGradient green = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xff65db9f), Color(0xff3da0a6)]);

const LinearGradient pink = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xffff70e7), Color(0xffff82ea6)]);

const LinearGradient blue = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xff3bc7ff), Color(0xff389af5)]);

class Moodo extends StatefulWidget {
  @override
  _MoodoState createState() => _MoodoState();
}

class _MoodoState extends State<Moodo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moodo',
        home: BlocProvider<ColorBloc>(
          create: (_) => ColorBloc(Colors.green),
          child: BlocBuilder<ColorBloc, Color>(
            builder: (context, color) {
              return BlocProvider<CountBloc>(
                create: (context) => CountBloc(0),
                child: MaterialApp(
                  // debugShowCheckedModeBanner: false,
                  // title: "Moodo",
                  // theme: ThemeData(
                  //     // Define the default brightness and colors.
                  //     primaryColor: colorSolid(theme),
                  //     accentColor: colorAccent(theme)),

                  debugShowCheckedModeBanner: false,
                  title: "Moodo",

                  home: SplashScreenView(
                    home: MainPage(
                      themeData: _theme(color),
                    ),
                    duration: 2000,
                    imageSize: 100,
                    imageSrc: "images/logo.png",
                    text: "Du'a for your daily mood",
                    textType: TextType.ColorizeAnimationText,
                    textStyle: TextStyle(fontSize: 14, fontFamily: "Poppins"),
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
