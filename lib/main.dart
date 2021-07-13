// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/bloc/favBloc.dart';
import 'package:moodo/bloc/themeBloc.dart';
import 'package:moodo/model/countBloc.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/mainPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future main() async {
  runApp(ProviderScope(child: Moodo()));
  WidgetsFlutterBinding.ensureInitialized();
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
  Future<String> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('theme') ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Moodo',
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeBloc>(
              create: (BuildContext context) => ThemeBloc(Style().gradasi),
            ),
            BlocProvider<CountBloc>(
                create: (BuildContext context) => CountBloc(0))
          ],
          child: BlocBuilder<ThemeBloc, LinearGradient>(
            builder: (context, themeData) {
              return MaterialApp(
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
                    themeData: themeData,
                  ),
                  duration: 2000,
                  imageSize: 100,
                  imageSrc: "images/logo.png",
                  text: "Du'a for your daily mood",
                  textType: TextType.ColorizeAnimationText,
                  textStyle: TextStyle(fontSize: 14, fontFamily: "Poppins"),
                  backgroundColor: Colors.white,
                ),
              );
            },
          ),
        ));
  }
}
