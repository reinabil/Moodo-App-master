import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/model/doa.dart';
import 'package:moodo/model/style.dart';
import 'package:sized_context/sized_context.dart';
import 'package:recase/recase.dart';

import 'detailDoaPage.dart';

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
    return BlocBuilder<ColorBloc, Color>(
      builder: (context, color) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
              borderRadius: BorderRadius.circular(200),
              splashColor: _themeActive(color).withAlpha(10),
              highlightColor: _themeActive(color).withAlpha(10),
              child: BlocBuilder<ColorBloc, Color>(
                builder: (context, color) {
                  return Container(
                    margin: EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      gradient: _theme(color),
                      boxShadow: [
                        BoxShadow(
                            color: _themeActive(color).withAlpha(100),
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
          body: BlocBuilder<ColorBloc, Color>(
            builder: (context, color) {
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
                            style:
                                Style(styleColor: _themeActive(color)).title1,
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
                                color: _themeActive(color).withAlpha(100),
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Doa doa = doaList![index];

                                            if (doa.mood
                                                    .toString()
                                                    .toLowerCase() ==
                                                moodo.toLowerCase())
                                              return _itemList(index, color);
                                            // if not return empty container
                                            else
                                              return Container();
                                          },
                                        );
                                      } else {
                                        LinearProgressIndicator(
                                          backgroundColor: Colors.white,
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        );
                                      }
                                      return LinearProgressIndicator(
                                        backgroundColor: Colors.white,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
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
      },
    );
  }

// if (doa.mood.toString() == moodo.toLowerCase())
//                               return _itemList(index);
//                             else
//                               return Container();

  _itemList(index, color) {
    Doa doa = doaList![index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: _theme(color),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: _themeActive(color).withAlpha(100),
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
                      DetailDoa(doa: doa, color: color)),
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
