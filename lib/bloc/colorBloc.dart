import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ColorEvent { green, pink, blue, purple, orange }

class ColorBloc extends HydratedBloc<ColorEvent, Color> {
  ColorBloc(Color initialState) : super(initialState);

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    yield (event == ColorEvent.pink)
        ? Colors.pink
        : (event == ColorEvent.blue)
            ? Colors.blue
            : (event == ColorEvent.purple)
                ? Colors.purple
                : (event == ColorEvent.orange)
                    ? Colors.orange
                    : Colors.green;
  }

  @override
  Color? fromJson(Map<String, dynamic> json) {
    try {
      return Color(json['color'] as int);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, int>? toJson(Color state) {
    try {
      return {'color': state.value};
    } catch (e) {
      return null;
    }
  }
}
