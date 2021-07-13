import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:moodo/bloc/themeBloc.dart';
import 'package:moodo/model/countBloc.dart';
import 'package:moodo/model/dzikir.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/detailDzikirPage.dart';
import 'package:recase/recase.dart';
import 'package:sized_context/sized_context.dart';

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

// ! Beda Sendiri ya INI
Color colorAccent(LinearGradient theme) =>
    (theme == Style().gradasiPink || theme == Style().gradasiPink2)
        ? Colors.red.shade900
        : (theme == Style().gradasiBiru || theme == Style().gradasiBiru2)
            ? Colors.blue.shade900
            : (theme == Style().gradasiUngu || theme == Style().gradasiUngu2)
                ? Colors.purple.shade900
                : (theme == Style().gradasiOrange ||
                        theme == Style().gradasiOrange2)
                    ? Colors.deepOrange.shade900
                    : Colors.teal.shade900;

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
    ? Style().gradasiPink2
    : (theme == Style().gradasiBiru)
        ? Style().gradasiBiru2
        : (theme == Style().gradasiUngu)
            ? Style().gradasiUngu2
            : (theme == Style().gradasiOrange)
                ? Style().gradasiOrange2
                : Style().gradasi2;

class ListDzikirPage extends StatefulWidget {
  final String dzikirVar;
  ListDzikirPage({
    required this.dzikirVar,
  });
  @override
  _ListDzikirPageState createState() => _ListDzikirPageState(this.dzikirVar);
}

class _ListDzikirPageState extends State<ListDzikirPage> {
  ScrollController _controller = ScrollController();
  String message = "";

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the bottom";
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "reach the top";
      });
    }
  }

  final ScrollController controller = ScrollController();
  List<Dzikir>? dzikirList;
  bool _isInit = true;

  final String dzikirVar;

  Future<void> fetchDzikir(BuildContext context) async {
    final jsonstring =
        await DefaultAssetBundle.of(context).loadString('assets/dzikir.json');
    dzikirList = dzikirFromJson(jsonstring);
    _isInit = false;
  }

  // ANCHOR Tambah Waktu
  _tambahWaktu() {
    fetchDzikir(context);
    List<Dzikir> dzikirWaktu = [];
    for (var i = 0; i < dzikirList!.length; i++) {
      Dzikir dzikir = dzikirList![i];
      if (dzikir.waktu.toString() == dzikirVar.toLowerCase())
        dzikirWaktu.add(dzikir);
    }
    return dzikirWaktu;
  }

  _ListDzikirPageState(this.dzikirVar);

  final itemSize = 100.0;
  _moveUp() {
    _controller.animateTo(_controller.offset - context.widthPct(1.002),
        curve: Curves.linear, duration: Duration(milliseconds: 200));
  }

  _moveDown() {
    _controller.animateTo(_controller.offset + context.widthPct(1.002),
        curve: Curves.linear, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    CountBloc countBloc = BlocProvider.of<CountBloc>(context);
    @override
    void initState() {
      _controller = ScrollController();
      _controller.addListener(_scrollListener);
      super.initState();
    }

    _onStartScroll(ScrollMetrics metrics) {
      return setState(() {
        message = "Scroll Start";
      });
    }

    _onUpdateScroll(ScrollMetrics metrics) {
      return setState(() {
        message = "Scroll Update";
      });
    }

    _onEndScroll(ScrollMetrics metrics) {
      return setState(() {
        message = "Scroll End";
      });
    }

    bool kanan = false;
    bool kiri = false;

    return BlocBuilder<ThemeBloc, LinearGradient>(
      builder: (context, theme) {
        return BlocBuilder<CountBloc, int>(
          builder: (context, count) {
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterFloat,
              floatingActionButton: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(1000),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(200),
                              splashColor: Colors.white,
                              highlightColor: colorAccent(theme).withAlpha(10),
                              onTap: () {
                                _moveDown();
                              },
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: colorActive(theme),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(1000),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(200),
                              splashColor: Colors.white,
                              highlightColor: colorAccent(theme).withAlpha(10),
                              onTap: () {
                                _moveUp();
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: colorActive(theme),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      width: (message == "Scroll Update")
                          ? 0
                          : context.widthPct(.42),
                      height: (message == "Scroll Update")
                          ? 0
                          : context.heightPct(.13),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 73,
                              height: 73,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorActive(theme),
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorActive(theme).withAlpha(100),
                                    blurRadius: 6,
                                    offset: Offset(0, 6),
                                  ),
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 30,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  count.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: colorAccent(theme)),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                              left: 0,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        gradient: theme,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 4)),
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(1000),
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          splashColor: colorActive(theme),
                                          highlightColor:
                                              colorAccent(theme).withAlpha(10),
                                          onTap: () {
                                            countBloc.add(0);
                                          },
                                          child: Icon(
                                            Icons.restart_alt_rounded,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ))),
                          Positioned.fill(
                              right: 0,
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        gradient: theme,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 4)),
                                    child: Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(1000),
                                      child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          splashColor: colorActive(theme),
                                          highlightColor:
                                              colorAccent(theme).withAlpha(10),
                                          onTap: () {
                                            //! ANCHOR tombol
                                            (count <= 99)
                                                ? countBloc.add(count + 1)
                                                : countBloc.add(0);
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              appBar: AppBar(
                leading: InkWell(
                  child: BlocBuilder<ThemeBloc, LinearGradient>(
                    builder: (context, theme) {
                      return Container(
                        margin: EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          gradient: bg(theme),
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
                  "Dzikir " + dzikirVar.titleCase,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: FutureBuilder(
                              future: _isInit ? fetchDzikir(context) : null,
                              builder: (context, _) {
                                if (dzikirList != null) {
                                  return NotificationListener<
                                      ScrollNotification>(
                                    onNotification: (scrollNotification) {
                                      if (scrollNotification
                                          is ScrollStartNotification) {
                                        _onStartScroll(
                                            scrollNotification.metrics);
                                        return true;
                                      } else if (scrollNotification
                                          is ScrollUpdateNotification) {
                                        _onUpdateScroll(
                                            scrollNotification.metrics);
                                        return true;
                                      } else if (scrollNotification
                                          is ScrollEndNotification) {
                                        _onEndScroll(
                                            scrollNotification.metrics);
                                        return true;
                                      } else
                                        return false;
                                    },
                                    // ANCHOR LIST VIEW

                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        controller: _controller,
                                        itemCount: _tambahWaktu().length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          Dzikir dzikir = _tambahWaktu()[index];
                                          if (dzikir.waktu.toString() ==
                                              dzikirVar.toLowerCase())
                                            return _itemList(index);
                                          else
                                            return Container();
                                        }),
                                  );
                                } else
                                  return Container();
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

// ANCHOR Add button

  _itemList(index) {
    Dzikir dzikir = _tambahWaktu()[index];
    return BlocBuilder<ThemeBloc, LinearGradient>(
      builder: (context, theme) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: SizedBox(
                    width: context.widthPct(.88),
                    child: GradientText(
                      dzikir.judul!,
                      gradient: theme,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: context.widthPct(.88),
                child: Center(
                  child: Text(
                    "Dibaca ${dzikir.dibaca}",
                    style: Style(styleColor: Colors.grey.shade600).body,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: context.widthPct(.88),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16, top: 8),
                              child: Text(
                                dzikir.lafaz!,
                                style:
                                    TextStyle(fontSize: 32, fontFamily: "Sil"),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DetailDzikirPage(
                                            dzikir: dzikir,
                                          )),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GradientText(
                                  "Baca selengkapnya",
                                  gradient: theme,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Poppins",
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
