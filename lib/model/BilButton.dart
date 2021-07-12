import 'package:flutter/material.dart';

// TODO Gradasi

/// ! Gradasi ijo
const LinearGradient gradasi = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xff65db9f), Color(0xff3da0a6)]);

/// Gradasi ijo terbalik
const LinearGradient gradasi2 = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xff3da0a6), Color(0xff65db9f)]);

/// ! Gradasi Pink
const LinearGradient gradasiPink = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xfffe717e), Color(0xfff8689c)],
);

/// Gradasi Pink terbalik
const LinearGradient gradasiPink2 = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [Color(0xfffe717e), Color(0xfff8689c)],
);

/// ! Gradasi Biru
const LinearGradient gradasiBiru = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff699bdf), Color(0xff4f81e1)],
);

/// Gradasi Biru terbalik
const LinearGradient gradasiBiru2 = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [Color(0xff699bdf), Color(0xff4f81e1)],
);

/// ! Gradasi Ungu
const LinearGradient gradasiUngu = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff8084dd), Color(0xff7b73cb)],
);

/// Gradasi Ungu terbalik
const LinearGradient gradasiUngu2 = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [Color(0xff8084dd), Color(0xff7b73cb)],
);

/// ! Gradasi Orange
const LinearGradient gradasiOrange = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xff8084dd), Color(0xffffc1a1), Color(0xffffa49d)],
);

/// Gradasi Orange terbalik
const LinearGradient gradasiOrange2 = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [Color(0xff8084dd), Color(0xffffc1a1), Color(0xffffa49d)],
);

class BilButton extends StatefulWidget {
  /// Primary color button
  ///
  /// *default* = `Colors.teal`
  final LinearGradient gradient;

  /// Splash color button
  ///
  /// *defaul* = `Colors.tealAccent`
  final Color splashColor;

  /// Shadow color button
  ///
  /// **with alpha 50 included**
  ///
  /// *defaul* = `Colors.tealAccent`
  final Color shadowColor;
  BilButton(
      {this.gradient = gradasi,
      this.splashColor = Colors.tealAccent,
      this.shadowColor = Colors.tealAccent});

  @override
  _BilButtonState createState() =>
      _BilButtonState(gradient, splashColor, shadowColor);
}

class _BilButtonState extends State<BilButton> {
  final LinearGradient gradient;
  final Color splashColor;
  final Color shadowColor;
  _BilButtonState(this.gradient, this.splashColor, this.shadowColor);
  bool isSelected = false;

  /// Warna tombol (background dan border)
  ///
  /// *default = Colors.teal*

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: AnimatedContainer(
            curve: Curves.ease,
            width: 300,
            height: 80,
            decoration: BoxDecoration(
                gradient: (!isSelected)
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffffffff), Color(0xffffffff)],
                      )
                    : gradasi,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withAlpha(50),
                    blurRadius: (isSelected) ? 9 : 18,
                    offset: (isSelected) ? Offset(0, 6) : Offset(0, 14),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                border: (isSelected)
                    ? null
                    : Border.all(color: splashColor, width: 5)),
            duration: Duration(milliseconds: 300),
          ),
        )
      ],
    );
  }
}
