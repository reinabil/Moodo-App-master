import 'package:flutter/material.dart';
import 'package:moodo/model/style.dart';

class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
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
          "Jurnal Moodo",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
