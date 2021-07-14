import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:moodo/bloc/colorBloc.dart';
import 'package:moodo/model/doa.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/detailDoaPage.dart';
import 'package:sized_context/sized_context.dart';
import 'package:gradient_text/gradient_text.dart';
import 'detailDoaPage.dart';
import 'package:collection/collection.dart';

// class FavPage extends StatefulWidget {
//   @override
//   _FavPageState createState() => _FavPageState();
// }
TextEditingController searchTxt = new TextEditingController();

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

LinearGradient _bg(Color color) => (color.value == 4293467747)
    ? Style().gradasiPink
    : (color.value == 4280391411)
        ? Style().gradasiBiru2
        : (color.value == 4288423856)
            ? Style().gradasiUngu2
            : (color.value == 4294940672)
                ? Style().gradasiOrange2
                : Style().gradasi2;

class FavPage extends ConsumerWidget {
  List<Doa>? doaList;
  Function eq = const ListEquality().equals;
  bool _isInit = true;

  Future<void> fetchDoa(BuildContext context) async {
    final jsonstring =
        await DefaultAssetBundle.of(context).loadString('assets/doa.json');
    doaList = doaFromJson(jsonstring);
    _isInit = false;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final favoriteIds = watch(FavoriteIds.provider);

    return Scaffold(body: BlocBuilder<ColorBloc, Color>(
      builder: (context, color) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(gradient: _bg(color)),
              ),
              //heading
              Container(
                margin:
                    EdgeInsets.only(top: 60 + 60 + context.widthPct(.8) / 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26)),
                  boxShadow: [
                    BoxShadow(
                      color: _themeActive(color).withAlpha(100),
                      blurRadius: 6.0,
                      offset: Offset(0, -7),
                    )
                  ],
                  color: Colors.white,
                ),
                child: eq(favoriteIds, [])
                    ? Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                  Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 00.0, 0.0),
                                      child: Lottie.asset(
                                          "assets/animation/empty.json")),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 64),
                                      child: Text(
                                        "Yah, doa favoritmu belom ada.\nYuk baca doa dulu biar gak tersesat di dunia yang penuh tipu daya :)",
                                        style: Style(
                                                styleColor:
                                                    Colors.grey.shade600)
                                            .caption,
                                        textAlign: TextAlign.center,
                                      )),
                                ])),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //ANCHOR FutureBuilder
                          Expanded(
                            child: FutureBuilder(
                                future: _isInit ? fetchDoa(context) : null,
                                builder: (context, _) {
                                  if (doaList != null) {
                                    return ListView.builder(
                                      itemCount: doaList!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Doa doa = doaList![index];
                                        if (favoriteIds
                                            .contains(doa.id.toString()))
                                          return _itemList(
                                              context, index, color);
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
                          )

                          // SizedBox(
                          //   height: context.widthPct(.22),
                          // )
                        ],
                      ),
              ),

              Container(
                margin: EdgeInsets.only(
                    top: (context.widthPct(.8) / 6) + 20, left: 60, right: 60),
                width: context.widthPct(.8),
                height: context.widthPct(.8) / 6,
                child: Center(
                  child: Text(
                    "Doa Favorite",
                    style: Style(styleColor: Colors.white).title1,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        );
      },
    ));
  }

  _itemList(context, index, color) {
    Doa doa = doaList![index];
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: ListTile(
            title: Text(doa.judul!.toString(),
                style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetailDoa(doa: doa, color: color)));
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: _themeActive(color),
            )));
  }
}
