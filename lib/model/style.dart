import 'package:flutter/material.dart';

class Style {
  Color styleColor;

  Style({this.styleColor = Colors.black});

  TextStyle get header => TextStyle(
        color: styleColor,
        fontSize: 24,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      );

  TextStyle get title1 => TextStyle(
        color: styleColor,
        fontSize: 28,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      );

  TextStyle get title2 => TextStyle(
        color: styleColor,
        fontSize: 22,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      );

  TextStyle get headline => TextStyle(
        color: styleColor,
        fontSize: 20,
        fontFamily: "Poppins",
      );

  TextStyle get body => TextStyle(
        color: styleColor,
        fontSize: 14,
        fontFamily: "Poppins",
      );

  TextStyle get caption => TextStyle(
        color: styleColor,
        fontSize: 12,
        fontFamily: "Poppins",
      );

  // TODO Gradasi

  /// ! Gradasi ijo
  final LinearGradient gradasi = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [Color(0xff65db9f), Color(0xff3da0a6)]);

  /// Gradasi ijo terbalik
  final LinearGradient gradasi2 = LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      colors: [Color(0xff3da0a6), Color(0xff65db9f)]);

  /// ! Gradasi Pink
  final LinearGradient gradasiPink = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.bottomCenter,
    colors: [Color(0xfffe717e), Color(0xfff8689c)],
  );

  /// Gradasi Pink terbalik
  final LinearGradient gradasiPink2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xfff8689c), Color(0xfffe717e)],
  );

  /// ! Gradasi Biru
  final LinearGradient gradasiBiru = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xff699bdf), Color(0xff4f81e1)],
  );

  /// Gradasi Biru terbalik
  final LinearGradient gradasiBiru2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xff699bdf), Color(0xff4f81e1)],
  );

  /// ! Gradasi Ungu
  final LinearGradient gradasiUngu = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xff8084dd), Color(0xff7b73cb)],
  );

  /// Gradasi Ungu terbalik
  final LinearGradient gradasiUngu2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xff8084dd), Color(0xff7b73cb)],
  );

  /// ! Gradasi Orange
  final LinearGradient gradasiOrange = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [Color(0xffFFAD83), Color(0xffFF8D84)],
  );

  /// Gradasi Orange terbalik
  final LinearGradient gradasiOrange2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xffFFAD83), Color(0xffFF8D84)],
  );
}
