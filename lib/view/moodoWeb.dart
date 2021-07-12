import 'package:flutter/material.dart';
import 'package:moodo/model/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoodoWeb extends StatefulWidget {
  const MoodoWeb({Key? key}) : super(key: key);

  @override
  _MoodoWebState createState() => _MoodoWebState();
}

class _MoodoWebState extends State<MoodoWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Container(
            margin: EdgeInsets.all(11),
            decoration: BoxDecoration(
              gradient: Style().gradasi,
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 67, 169, 165),
                    offset: Offset(1, 2),
                    blurRadius: 3)
              ],
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Jurnal Harian",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
          child: WebView(
        initialUrl: 'https://moodo.my.id/',
      )),
    );
  }
}
