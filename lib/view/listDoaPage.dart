import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodo/bloc/themeBloc.dart';
import 'package:moodo/model/doa.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/detailDoaPage.dart';
import 'package:sized_context/sized_context.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:recase/recase.dart';

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

class ListDoaPage extends StatefulWidget {
  @override
  _ListDoaPageState createState() => _ListDoaPageState();
}

class _ListDoaPageState extends State<ListDoaPage> {
  List<Doa>? doaList;

  // controller to get text
  TextEditingController searchTxt = new TextEditingController();

  bool _isInit = true;

  Future<void> fetchDoa(BuildContext context) async {
    final jsonstring =
        await DefaultAssetBundle.of(context).loadString('assets/doa.json');
    doaList = doaFromJson(jsonstring);
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<ThemeBloc, LinearGradient>(
          builder: (context2, theme) {
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: bg(theme),
                    ),
                  ),
                  //heading
                  Container(
                    margin: EdgeInsets.only(
                        top: 60 + 60 + context.widthPct(.8) / 6),
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
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(40, 40, 16, 8),
                          child: GradientText(
                            "Daftar Doa",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            gradient: bg(theme),
                          ),
                        ),
                        //ANCHOR FutureBuilder
                        Expanded(
                          child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: CupertinoScrollbar(
                              child: FutureBuilder(
                                  future: _isInit ? fetchDoa(context) : null,
                                  builder: (context, _) {
                                    if (doaList != null) {
                                      return ListView.builder(
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        itemCount: doaList!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Doa doa = doaList![index];

                                          // Edit by Pathik Patel
                                          String searchSrc = doaList![index]
                                              .judul
                                              .toString()
                                              .toLowerCase();
                                          String searchTgt =
                                              searchTxt.text.toLowerCase();
                                          // return _itemList(index);
                                          // if search query is empty or
                                          // current item text contains search query
                                          if (searchTgt == "" ||
                                              searchSrc.contains(searchTgt))
                                            return _itemList(index);
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
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ANCHOR Search Bar
                  _searchBar()
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _itemList(index) {
    Doa doa = doaList![index];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BlocBuilder<ThemeBloc, LinearGradient>(
        builder: (context, theme) {
          return ListTile(
            title: Text(doa.judul!.titleCase,
                style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailDoa(doa: doa, theme: theme)),
              );
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: colorActive(theme),
            ),
          );
        },
      ),
    );
  }

  _searchBar() {
    return SingleChildScrollView(
      child: BlocBuilder<ThemeBloc, LinearGradient>(
        builder: (context, theme) {
          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 75),
              width: context.widthPct(.8),
              height: context.widthPct(.8) / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                color: Colors.grey[200],
              ),
              child: Container(
                child: Theme(
                  data: new ThemeData(
                      primaryColor: Colors.grey[200],
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: colorActive(theme).withAlpha(100),
                        selectionColor: colorActive(theme).withAlpha(70),
                        selectionHandleColor: colorActive(theme),
                      )),
                  child: TextField(
                    // controller to get text
                    controller: searchTxt,
                    onChanged: (String str) {
                      str = str.toLowerCase();
                      setState(() {});
                    },
                    autofocus: false,
                    style: TextStyle(
                        color: Colors.grey[700], fontFamily: "Poppins"),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[700],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                      hintText: "Cari doa dulu yuk",
                      hintStyle: TextStyle(
                          color: Colors.grey[700], fontFamily: "Poppins"),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(200),
                          borderSide: new BorderSide(
                              color: colorActive(theme).withAlpha(100))),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(200),
                        borderSide: new BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
