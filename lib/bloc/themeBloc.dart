import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodo/model/style.dart';
import 'dart:ui';

enum ThemeEvent { green, pink, blue, purple, orange }

class ThemeBloc extends Bloc<ThemeEvent, LinearGradient> {
  ThemeBloc(LinearGradient initialState) : super(initialState);
  LinearGradient get initialState => Style().gradasi;

  @override
  Stream<LinearGradient> mapEventToState(ThemeEvent event) async* {
    yield (event == ThemeEvent.pink)
        ? Style().gradasiPink
        : (event == ThemeEvent.blue)
            ? Style().gradasiBiru
            : (event == ThemeEvent.purple)
                ? Style().gradasiUngu
                : (event == ThemeEvent.orange)
                    ? Style().gradasiOrange
                    : Style().gradasi;
  }
}
