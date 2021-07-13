import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:lottie/lottie.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/bloc/themeBloc.dart';
import 'package:moodo/model/doa.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sized_context/sized_context.dart';
import 'package:moodo/model/style.dart';
import 'moodPage.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:moodo/model/BilButton.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

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
                ? Colors.purple
                : (theme == Style().gradasiOrange ||
                        theme == Style().gradasiOrange2)
                    ? Colors.orange.shade900
                    : Colors.teal;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeBloc bloc = BlocProvider.of<ThemeBloc>(context);
    final ScrollController listViewController = new ScrollController();
    return SnappingSheet(
      child: Background(),
      lockOverflowDrag: true,
      snappingPositions: [
        SnappingPosition.factor(
          positionFactor: 0.1,
          snappingCurve: Curves.easeOutExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.top,
        ),
        SnappingPosition.factor(
          positionFactor: 0.15,
          snappingCurve: Curves.easeOutExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.top,
        ),
        SnappingPosition.factor(
          snappingCurve: Curves.elasticOut,
          snappingDuration: Duration(milliseconds: 1750),
          positionFactor: 0.7,
        ),
      ],
      grabbing: Container(
        child: BlocBuilder<ThemeBloc, LinearGradient>(
          builder: (context, theme) {
            return GrabbingWidget(
              theme: theme,
            );
          },
        ),
      ),
      grabbingHeight: 100,
      sheetAbove: null,
      sheetBelow: SnappingSheetContent(
        draggable: true,
        childScrollController: listViewController,
        child: Container(
          color: Colors.white,
          child: _sheet(listViewController, bloc),
        ),
      ),
    );
  }
}

// Align(
//   alignment: Alignment.topLeft,
//   child: Text(
//     "Pilih tema warna",
//     style: Style().headline,
//     textAlign: TextAlign.left,
//   ),
// ),
// ANCHOR Button tema
// Container(
//   margin: EdgeInsets.symmetric(vertical: 0),
//   child: Wrap(
//     spacing: 16,
//     children: [
//       GestureDetector(
//         onTap: () {},
//         child: Material(
//           borderRadius: BorderRadius.circular(100),
//           elevation: 10,
//           shadowColor: Colors.teal,
//           child: Stack(
//             children: <Widget>[
//               SizedBox(
//                 width: context.widthPct(.14),
//                 height: context.widthPct(.14),
//                 child: Material(
//                     borderRadius:
//                         BorderRadius.circular(100),
//                     color: Colors.transparent),
//               ),
//               Container(
//                 width: context.widthPct(.14),
//                 height: context.widthPct(.14),
//                 decoration: BoxDecoration(
//                     gradient: Style().gradasi,
//                     borderRadius:
//                         BorderRadius.circular(100)),
//               )
//             ],
//           ),
//         ),
//       )
//     ],
//   ),
// ),

class GrabbingWidget extends StatelessWidget {
  LinearGradient theme;
  GrabbingWidget({required this.theme});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: colorActive(theme).withAlpha(100)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 10),
            width: 80,
            height: 7,
            decoration: BoxDecoration(
              gradient: theme,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0, top: 10),
            child: Align(
              alignment: Alignment.center,
              child: GradientText(
                "Hai, gimana kabarmu?",
                textAlign: TextAlign.center,
                style: Style(styleColor: Colors.black).title2,
                gradient: theme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_sheet(ScrollController s, ThemeBloc bloc) {
  return BlocBuilder<ThemeBloc, LinearGradient>(
    builder: (context, theme) {
      return ListView(
        padding: EdgeInsets.all(0),
        controller: s,
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            shadowColor: colorActive(theme).withAlpha(100),
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                children: <Widget>[
                  Text(
                    "اَلَا بِذِکۡرِ اللّٰہِ تَطۡمَئِنُّ الۡقُلُوۡبُ",
                    style: TextStyle(fontSize: 32, fontFamily: "Sil"),
                  ),
                  Text(
                    "Alaa bidzikrillahi tathma-innul quluub(u);",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: colorActive(theme)),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Ingatlah, hanya dengan mengingat Allah hati menjadi tenteram.(QS. Ar Ra’d: 28)",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            child: Wrap(
              spacing: 24,
              alignment: WrapAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => MoodPage(
                                moodo: "Sedih",
                              )),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: context.widthPct(.25),
                          height: context.heightPct(.25),
                          child: Lottie.asset("assets/animation/sad.json")),
                      Container(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: Text("Sedih",
                            style:
                                Style(styleColor: Colors.grey.shade600).body),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => MoodPage(
                                moodo: "Biasa aja",
                              )),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                          width: context.widthPct(.25),
                          height: context.heightPct(.25),
                          child: Lottie.asset("assets/animation/netral.json")),
                      Container(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: Text("Biasa aja",
                            style:
                                Style(styleColor: Colors.grey.shade600).body),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => MoodPage(
                                moodo: "Senang",
                              )),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                          width: context.widthPct(.25),
                          height: context.heightPct(.25),
                          child: Lottie.asset("assets/animation/happy.json")),
                      Container(
                        transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                        child: Text("Senang",
                            style:
                                Style(styleColor: Colors.grey.shade600).body),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GradientText(
            "Apa warna kesukaanmu?",
            textAlign: TextAlign.center,
            style: Style(styleColor: Colors.black).title2,
            gradient: theme,
          ),
          Container(
              width: context.widthPct(.5),
              height: context.heightPct(.6),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AnimatedContainer(
                    width: context.widthPct(.7),
                    height: context.heightPct(.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: colorActive(theme).withAlpha(100),
                          blurRadius: 21,
                          offset: Offset(0, 10),
                        ),
                      ],
                      gradient: theme,
                    ),
                    duration: Duration(milliseconds: 700),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // ! ijo
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              bloc.add(ThemeEvent.green);
                            },
                            child: AnimatedContainer(
                              curve: Curves.bounceOut,
                              duration: Duration(milliseconds: 700),
                              width: (theme == Style().gradasi) ? 70 : 55,
                              height: (theme == Style().gradasi) ? 70 : 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius:
                                        (theme == Style().gradasi) ? 10 : 23,
                                    offset: (theme == Style().gradasi)
                                        ? Offset(0, 10)
                                        : Offset(0, 6),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color(0xff65db9f),
                                    Color(0xff3da0a6)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // ! biru
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              bloc.add(ThemeEvent.blue);
                            },
                            child: AnimatedContainer(
                              curve: Curves.bounceOut,
                              duration: Duration(milliseconds: 700),
                              width: (theme == Style().gradasiBiru) ? 70 : 55,
                              height: (theme == Style().gradasiBiru) ? 70 : 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius: (theme == Style().gradasiBiru)
                                        ? 10
                                        : 23,
                                    offset: (theme == Style().gradasiBiru)
                                        ? Offset(0, 10)
                                        : Offset(0, 6),
                                  ),
                                ],
                                gradient: Style().gradasiBiru,
                              ),
                            ),
                          ),
                        ),
                        // ! ungu
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              bloc.add(ThemeEvent.purple);
                            },
                            child: AnimatedContainer(
                              curve: Curves.bounceOut,
                              duration: Duration(milliseconds: 700),
                              width: (theme == Style().gradasiUngu) ? 70 : 55,
                              height: (theme == Style().gradasiUngu) ? 70 : 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius: (theme == Style().gradasiUngu)
                                        ? 10
                                        : 23,
                                    offset: (theme == Style().gradasiUngu)
                                        ? Offset(0, 10)
                                        : Offset(0, 6),
                                  ),
                                ],
                                gradient: Style().gradasiUngu,
                              ),
                            ),
                          ),
                        ),
                        // ! oren
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              bloc.add(ThemeEvent.orange);
                            },
                            child: AnimatedContainer(
                              curve: Curves.bounceOut,
                              duration: Duration(milliseconds: 700),
                              width: (theme == Style().gradasiOrange) ? 70 : 55,
                              height:
                                  (theme == Style().gradasiOrange) ? 70 : 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius: (theme == Style().gradasiOrange)
                                        ? 10
                                        : 23,
                                    offset: (theme == Style().gradasiOrange)
                                        ? Offset(0, 10)
                                        : Offset(0, 6),
                                  ),
                                ],
                                gradient: Style().gradasiOrange,
                              ),
                            ),
                          ),
                        ),
                        // ! merah
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              bloc.add(ThemeEvent.pink);
                            },
                            child: AnimatedContainer(
                              curve: Curves.bounceOut,
                              duration: Duration(milliseconds: 700),
                              width: (theme == Style().gradasiPink) ? 70 : 55,
                              height: (theme == Style().gradasiPink) ? 70 : 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    blurRadius: (theme == Style().gradasiPink)
                                        ? 10
                                        : 23,
                                    offset: (theme == Style().gradasiPink)
                                        ? Offset(0, 10)
                                        : Offset(0, 6),
                                  ),
                                ],
                                gradient: Style().gradasiPink,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _wah(theme)),
                  // ! motivasi
                  AnimatedContainer(
                    width: context.widthPct(.7),
                    height: context.heightPct(.08),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2000),
                      boxShadow: [
                        BoxShadow(
                          color: colorActive(theme).withAlpha(100),
                          blurRadius: 21,
                          offset: Offset(0, 10),
                        ),
                      ],
                      gradient: theme,
                    ),
                    duration: Duration(milliseconds: 500),
                    child: psikologiWarna(theme),
                  )
                ],
              )),
        ],
      );
    },
  );
}

_wah(LinearGradient theme) {
  String warna = (theme == Style().gradasiPink)
      ? "merah"
      : (theme == Style().gradasiBiru)
          ? "biru"
          : (theme == Style().gradasiUngu)
              ? "ungu"
              : (theme == Style().gradasiOrange)
                  ? "oren"
                  : "hijau";

  return Text(
    "Orang yang suka warna $warna itu",
    style: TextStyle(fontFamily: 'Poppins', color: Colors.grey),
  );
}

psikologiWarna(LinearGradient theme) {
  // ! ijo
  if (theme == gradasi) {
    return Center(
        child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        RotateAnimatedText(
          "Setia",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Penyayang",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Gampang bergaul",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
  // ! biru
  else if (theme == Style().gradasiBiru) {
    return Center(
        child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        RotateAnimatedText(
          "Tegar",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Lembut",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Penyabar",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
  // ! ungu
  else if (theme == Style().gradasiUngu) {
    return Center(
        child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        RotateAnimatedText(
          "Kreatif",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Mandiri",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Bijak",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
  // ! oren
  else if (theme == Style().gradasiOrange) {
    return Center(
        child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        RotateAnimatedText(
          "Optimistis",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Bisa dipercaya",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Pantang menyerah",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
  // ! pink
  else if (theme == Style().gradasiPink) {
    return Center(
        child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        RotateAnimatedText(
          "Bikin orang nyaman",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Suka kedamaian",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        RotateAnimatedText(
          "Punya mimpi tinggi",
          textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}

class Background extends StatelessWidget {
  bool isPressed = false;
  var now = new DateTime.now();
  var waktu = Waktu();
  var hijri = new HijriCalendar.now();
  final int random = Random().nextInt(128);
  List<Doa>? doaList;
  bool _isInit = true;

  Future<void> fetchDoa(BuildContext context) async {
    final jsonstring =
        await DefaultAssetBundle.of(context).loadString('assets/doa.json');
    doaList = doaFromJson(jsonstring);
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController listViewController = new ScrollController();
    ThemeBloc bloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      body: BlocBuilder<ThemeBloc, LinearGradient>(
          // ! theme == tema aplikasi
          builder: (context, theme) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: <Widget>[
            AnimatedContainer(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  // gradient: green,
                  gradient: theme),
              duration: Duration(milliseconds: 2000),
              curve: Curves.ease,
            ),
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
                  child: Column(
                    children: [
                      Text(
                        "Assalamualaikum",
                        style: Style(styleColor: Colors.white).header,
                      ),
                      Text(
                        Waktu(now).format('EEEE, d MMMM y'),
                        style: Style(styleColor: Colors.white).body,
                      ),
                      Text(
                        hijri.toFormat("dd MMMM yyyy"),
                        style: Style(styleColor: Colors.white).caption,
                      ),

                      // Container(
                      //   height: context.heightPct(.2),
                      // ),
                      FutureBuilder(
                          future: _isInit ? fetchDoa(context) : null,
                          builder: (context, _) {
                            if (doaList != null) {
                              Doa doa = doaList![
                                  int.parse(Waktu(now).format('d')) + 51];
                              return Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 4,
                                shadowColor: colorActive(theme).withAlpha(100),
                                child: Container(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    children: [
                                      GradientText(
                                        "Doa of The Day",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                        gradient: theme,
                                      ),
                                      Text("${doa.judul}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "${doa.lafaz}",
                                        style: TextStyle(
                                            fontSize: 32, fontFamily: "Sil"),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${doa.latin}",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            color: colorActive(theme)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("${doa.arti}",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            } else
                              return Padding(
                                padding: const EdgeInsets.only(top: 32.0),
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.teal,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                ),
                              );
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: context.heightPct(.3),
                )
              ],
            ),
            // ANCHOR Tentang aplikasi
            SafeArea(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.info_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      NAlertDialog(
                        title: Text(
                          "Tentang Aplikasi",
                          style: Style().headline,
                        ),
                        content: Container(
                          width: context.widthPct(.5),
                          height: context.heightPct(.4),
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            removeBottom: true,
                            context: context,
                            child: CupertinoScrollbar(
                              child: ListView(
                                children: [
                                  Center(
                                    child: Image.asset(
                                        "assets/logo_horizontal.png"),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Sumber data doa :\nApa Doanya app\n\nTerima kasih sudah\nmenggunakan Moodo :D\n",
                                      style: Style().body,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "😎 nabilrei 😎\n😄 hantsnm 😄\n😇 rennyatikas 😇\n🤗 cayne.dameron 🤗\n",
                                      style: Style(
                                              styleColor: Colors.grey.shade600)
                                          .caption,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "Ilustrasi :\nhttps://lottiefiles.com/51382-astronaut-light-theme\nhttps://lottiefiles.com/crestart\n",
                                      style: Style(
                                              styleColor: Colors.grey.shade600)
                                          .caption,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "versi 2.0.0",
                                      style: Style(
                                              styleColor: Colors.grey.shade600)
                                          .caption,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        blur: 0,
                      ).show(context,
                          transitionType: DialogTransitionType.NONE);
                    }),
                // ! tema aplikasi
              ],
            ))
          ]),
        );
      }),
    );
  }
}
