import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:moodo/bloc/themeBloc.dart';
import 'package:moodo/model/doa.dart';
import 'package:moodo/model/style.dart';
import 'package:sized_context/sized_context.dart';
import 'package:recase/recase.dart';

import 'detailDoaPage.dart';

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

LinearGradient bg(LinearGradient theme) => (theme == Style().gradasiPink)
    ? Style().gradasiPink
    : (theme == Style().gradasiBiru)
        ? Style().gradasiBiru2
        : (theme == Style().gradasiUngu)
            ? Style().gradasiUngu2
            : (theme == Style().gradasiOrange)
                ? Style().gradasiOrange2
                : Style().gradasi2;

class MoodPage extends StatefulWidget {
  final String moodo;
  MoodPage({
    required this.moodo,
  });
  @override
  _MoodPageState createState() => _MoodPageState(this.moodo);
}

class _MoodPageState extends State<MoodPage> {
  List<Doa>? doaList;
  // controller to get text

  bool _isInit = true;
  final String moodo;
  Future<void> fetchDoa(BuildContext context) async {
    final jsonstring =
        await DefaultAssetBundle.of(context).loadString('assets/doa.json');
    doaList = doaFromJson(jsonstring);
    _isInit = false;
  }

  _MoodPageState(this.moodo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: BlocBuilder<ThemeBloc, LinearGradient>(
            builder: (context, theme) {
              return Container(
                margin: EdgeInsets.all(11),
                decoration: BoxDecoration(
                  gradient: theme,
                  boxShadow: [
                    BoxShadow(
                        color: colorActive(theme).withAlpha(100),
                        offset: Offset(1, 2),
                        blurRadius: 3)
                  ],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              );
            },
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Doa",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<ThemeBloc, LinearGradient>(
        builder: (context, theme) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: (context.widthPct(.7) / 7), left: 40, right: 40),
                width: context.widthPct(.8),
                height: context.widthPct(.8),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Doa yang pas buat kamu yang lagi",
                        style: Style(styleColor: Colors.grey.shade600).body,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        moodo,
                        style: Style(styleColor: colorActive(theme)).title1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              //heading
              DraggableScrollableSheet(
                  initialChildSize: 0.8,
                  maxChildSize: 1,
                  minChildSize: 0.8,
                  builder: (BuildContext c, s) {
                    return Container(
                      padding: EdgeInsets.only(top: 0),
                      margin: EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colorActive(theme).withAlpha(100),
                            blurRadius: 6.0,
                            offset: Offset(0, -7),
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32,
                          ),
                          //ANCHOR FutureBuilder
                          Expanded(
                            child: FutureBuilder(
                                future: _isInit ? fetchDoa(context) : null,
                                builder: (context, _) {
                                  if (doaList != null) {
                                    return ListView.builder(
                                      controller: s,
                                      itemCount: doaList!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Doa doa = doaList![index];

                                        if (doa.mood.toString().toLowerCase() ==
                                            moodo.toLowerCase())
                                          return _itemList(index, theme);
                                        // if not return empty container
                                        else
                                          return Container();
                                      },
                                    );
                                  } else {
                                    LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    );
                                  }
                                  return LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          );
        },
      ),
    );
  }

// if (doa.mood.toString() == moodo.toLowerCase())
//                               return _itemList(index);
//                             else
//                               return Container();

  _itemList(index, theme) {
    Doa doa = doaList![index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: theme,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: colorActive(theme).withAlpha(100),
                  blurRadius: 3,
                  offset: Offset(2, 5)),
            ]),
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Text(doa.judul!.titleCase,
              style: TextStyle(
                  fontFamily: "Poppins", fontSize: 16, color: Colors.white)),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailDoa(doa: doa, theme: theme)),
            );
          },
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
