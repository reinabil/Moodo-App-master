import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:moodo/bloc/themeBloc.dart';
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

    return Scaffold(body: BlocBuilder<ThemeBloc, LinearGradient>(
      builder: (context, theme) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(gradient: bg(theme)),
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
                      color: colorActive(theme).withAlpha(100),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                  Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 50.0, 0.0),
                                      child: Lottie.asset(
                                          "assets/animation/empty.json")),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 64),
                                      child: Text(
                                        "Yuk cari doa dulu dan masukkan doanya ke daftar doa favoritmu",
                                        style: Style(
                                                styleColor:
                                                    Colors.grey.shade600)
                                            .body,
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
                                              context, index, theme);
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

  _itemList(context, index, theme) {
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
                      DetailDoa(doa: doa, theme: theme)));
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: colorActive(theme),
            )));
  }
}
