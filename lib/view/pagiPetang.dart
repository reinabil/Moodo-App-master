import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:format_indonesia/format_indonesia.dart';
import 'package:lottie/lottie.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/model/dzikir.dart';
import 'package:moodo/view/detailDoaPage.dart';
import 'package:moodo/view/detailDzikirPage.dart';
import 'package:sized_context/sized_context.dart';
import 'package:moodo/model/style.dart';
import 'listDzikirPage.dart';

Color _themeSolid(Color color) => (color.value == 4293467747)
    ? Colors.red
    : (color.value == 4280391411)
        ? Colors.blue
        : (color.value == 4288423856)
            ? Colors.purple
            : (color.value == 4294940672)
                ? Colors.yellow
                : Colors.teal;

Color _themeActive(Color color) => (color.value == 4293467747)
    ? Colors.redAccent
    : (color.value == 4280391411)
        ? Colors.blueAccent
        : (color.value == 4288423856)
            ? Colors.purple
            : (color.value == 4294940672)
                ? Colors.orange.shade900
                : Colors.teal;

LinearGradient _theme(Color color) => (color.value == 4293467747)
    ? Style().gradasiPink
    : (color.value == 4280391411)
        ? Style().gradasiBiru
        : (color.value == 4288423856)
            ? Style().gradasiUngu
            : (color.value == 4294940672)
                ? Style().gradasiOrange
                : Style().gradasi;

LinearGradient _savedTheme(Color color) => (color.value == 4293467747)
    ? Style().gradasiPink
    : (color.value == 4280391411)
        ? Style().gradasiBiru
        : (color.value == 4288423856)
            ? Style().gradasiUngu
            : (color.value == 4294940672)
                ? Style().gradasiOrange
                : Style().gradasi;

class PagiPetangPage extends StatefulWidget {
  @override
  _PagiPetangPageState createState() => _PagiPetangPageState();
}

class _PagiPetangPageState extends State<PagiPetangPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorBloc, Color>(
      builder: (context, color) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: <Widget>[
            Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  gradient: _theme(color),
                )),
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
                  child: Column(
                    children: [
                      Text(
                        "Dzikir Pagi - Petang",
                        style: Style(styleColor: Colors.white).header,
                      ),
                      Container(
                        height: context.heightPct(.01),
                      ),
                      Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                        shadowColor: _themeActive(color).withAlpha(100),
                        child: Container(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            children: [
                              GradientText(
                                "Keutamaan",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                                gradient: _theme(color),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "فَسُبْحَانَ اللَّهِ حِينَ تُمْسُونَ وَحِينَ تُصْبِحُونَ",
                                style:
                                    TextStyle(fontSize: 32, fontFamily: "Sil"),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Fasubhaana allaahi hiina tumsuuna wahiina tushbihuuna",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: _themeActive(color)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Maka bertasbihlah kepada Allah di waktu kamu berada di sore hari dan waktu kamu berada di waktu pagi hari. (QS. Ar-Rum:17)",
                                  style: Style(styleColor: Colors.black).body)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: context.heightPct(.3),
                )
              ],
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.35,
                maxChildSize: 0.35,
                minChildSize: 0.35,
                builder: (BuildContext c, s) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        boxShadow: [
                          BoxShadow(
                            color: _themeActive(color).withAlpha(100),
                            blurRadius: 6.0,
                            offset: Offset(0, -7),
                          )
                        ]),
                    child: Wrap(
                      spacing: 40,
                      alignment: WrapAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ListDzikirPage(
                                        dzikirVar: 'pagi',
                                      )),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                  transform: Matrix4.translationValues(
                                      0.0, -40.0, 0.0),
                                  width: context.widthPct(.3),
                                  height: context.heightPct(.3),
                                  child: Lottie.asset(
                                      "assets/animation/sun.json")),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -90.0, 0.0),
                                child: Text("Dzikir Pagi",
                                    style:
                                        Style(styleColor: Colors.grey.shade600)
                                            .body),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ListDzikirPage(
                                        dzikirVar: 'petang',
                                      )),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                  transform: Matrix4.translationValues(
                                      0.0, -40.0, 0.0),
                                  width: context.widthPct(.3),
                                  height: context.heightPct(.3),
                                  child: Lottie.asset(
                                      "assets/animation/moon.json")),
                              Container(
                                transform:
                                    Matrix4.translationValues(0.0, -90.0, 0.0),
                                child: Text("Dzikir Petang",
                                    style:
                                        Style(styleColor: Colors.grey.shade600)
                                            .body),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ]),
        );
      },
    );
  }
}
